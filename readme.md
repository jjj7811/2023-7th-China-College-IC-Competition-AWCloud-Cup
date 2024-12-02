# 基于FPGA的铝材缺陷检测系统

## 一、总体概述

### 1.1 系统框图

系统总体运行由HPS端调度，FPGA端作为HPS端并行运行加速部分，主要作用是为HPS端执行卷积加速、HDMI显示等功能，因此，我们可以通过将HPS端执行的数据重排、预处理、resize、plot等操作移动到FPGA端进行并行运行，这样就可以加速整个系统的运行速度。

![image-20241202125611901](readme.assets/image-20241202125611901.png)

#### PL PS通信

FPGA端与HPS端沟通主要通过多个总线，有由FPGA端发起的数据传输f2h_sdram总线，f2h_axi总线，也有由HPS下达指令的lw_axi总线。FPGA数据通过总线传输到PS端ddr3中。在Linux系统中FPGA相当于其外设，因此使用的是DMA等驱动对数据进行搬运，传输的数据在Linux系统中处于内核空间，将其搬移到用户空间后我们就可以使用用户程序对数据进行操作。

| 组件名           | 桥接                    | Hps连接端口       |
| ---------------- | ----------------------- | ----------------- |
| mm_bridge_sdram0 | FPGA to SDRAM           | f2h_sdram0_data   |
| mm_bridge_axi    | FPGA-to-HPS             | f2h_axi_slave     |
| mm_bridge_lw_axi | Lightweight HPS-to-FPGA | h2f_lw_axi_master |

#### 部署模型

模型部分是整个系统进行推理的基础，主要分为模型训练以及模型部署，训练框架使用PaddleDetection，推理框架使用Paddle-Lite。针对训练的模型优化，主要集中于模型精度的提升以及模型大小的压缩，针对部署的模型优化，就是在PS端对intel_SDK以及推理框架Paddle-Lite的优化。

### 1.2 优化策略

#### FPGA侧

本系统通过**重写**dvp_ddr3、ddr3_vga等官方ip，利用FPGA并行计算的优势，将HPS部分推理流程中的多个任务**并行**到FPGA实现，例如对图像的**resize**以及推理结果的**plot**叠加。同时通过**时序约束**、**逻辑固化、去除无用组件**等方式提高cnn加速器的运行频率，加速了HDMI显示刷新速度以及推理速度。

#### 模型侧

在模型方面，我们通过使用**本地数据增强**、使用**剪枝策略**进行剪枝、优化**小目标检测精度**、进行**输出层缩放**、修改**单通道模型**等方式提升模型精度并压缩模型大小。

#### Linux侧

在SDK以及推理框架Paddle-Lite方面，我们使用**Neon**指令集、开启**O3**优化、使用**OpenMP**、进行**循环展开**等方式优化了PS端的数据重排。在Paddle-Lite中**开启多核心推理**，推理过程使用**单通道模型与数据**，加速推理速度。

在构建实时推理系统时，使用一个SSD_Detection进程，完成实时推理的刷新工作，每完成一帧的推理，将推理结果写入PL_Plot控制寄存器中，从而完成HDMI上的实时推理结果叠加显示。而推理工作，将完全由FPGA进行，当DVP_DDR模块将图像写入BUF0时，DDR_VGA模块从BUF1中读取数据并使用PL_Plot模块叠加预测框，完成推理结果的显示以及视频流刷新工作。

### 1.3 程序架构

在总决赛中，我们抛弃了分区赛使用的双进程方案，引入PL端绘制预测框思想，从而可将双核ARM-A9全部用于推理，有效提升CPU的利用率，并且解决了双进程读取DDR冲突的问题，通过改方法，可以提升推理刷新时间稳定性，并可将推理时间提升10ms。下面我们将两种方案都进行阐述，进行比较。

#### 总决赛方案

我们设计了PL端绘制预测框的IP，通过h2f_lw_bridge控制状态寄存器，从而控制PL_Plot IP的绘制，其状态寄存器说明如下图所示。

![image-20241202130044402](readme.assets/image-20241202130044402.png)

我们设计了一个SSD_Detction进程，其从BUF2~BUF3中读取经过PL侧Resize后的300*300单通道图像，转换为Tensor结构后进行使用PaddleLite推理，将推理结果写入PL_Plot寄存器，从而实现推理结果的叠加显示。

![image-20241202130035476](readme.assets/image-20241202130035476.png)

#### 分区赛方案

我们的系统将使用**两个进程**完成，他们中间通过共享内存的方式进行进程间通信。他们分别的工作是：

1. 进程ssd_detection用于从ddr中获取原始图像数据，进行模型的推理。并将PaddleLite推理结果拷贝入共享内存，给进程2使用。
2. 进程ssd_hdmi用于从ddr中获取图像原始数据，从共享内存中拷贝推理结果，并使用visualize_result()函数将推理结果叠加到原图像，通过ddr_vga IP将叠加后的图像推流到HDMI显示。

由于使用两个进程，其推理与HDMI视频流推流过程是**独立**的，在推理结果并未刷新前，原图像叠加上一次的推理结果进行输出，其相互独立互不影响。

注：由于ssd_hdmi进程运行较快，为了降低CPU资源占用，我们使用usleep() 函数将进程休眠，并且由于系统中大部分进程均运行于cpu0上，为了保证推理速率，我们将ssd_hdmi视频推流进程绑定于cpu0运行，推理进程ssd_detction独占cpu1。并提高推理进程ssd_detction的任务优先级为0，降低视频推流进程ssd_hdmi的任务优先级为**39**。如此可减少两个进程对于资源的抢占，在不降低视频流帧率的情况下，加快推理速度。

![image-20241202130123204](readme.assets/image-20241202130123204.png)

## 二、关键技术分析

### 2.1 FPGA端优化

#### 重写dvp_ddr3与ddr3_vga

由于官方提供的dvp_ddr3以及ddr3_vga的两个ip，其需要使用HPS端进行调度，严重影响推理程序的速度，同时HDMI速度也受到损失，因此最好能够将HDMI显示完全与HPS端分离，得到的帧数据直接传输到HPS端DDR3的指定双buffer中，从buffer直接读取数据然后推理，这样无需PS调度，加快了推理速度同时加快了HDMI显示速度。

同时，官方提供的ip我们无法进行自定义的修改，如修改为单通道、将resize、图像预处理模块添加进入ip中。通过自定义ip，我们可以将想要实现的操作加入模块ip中，以提升推理准确度、推理速度等指标。

为了便于移植，我们将dvp_ddr3与ddr3_vga整合为一个ip即dvp_ddr3_vga。

**•绘制dvp_ddr3_vga总体框图如下：**

![image-20241202130656412](readme.assets/image-20241202130656412.png)

**•dvp_ddr3_vga****模块组成如下：

| 模块名称         | 功能描述                                                     |
| ---------------- | ------------------------------------------------------------ |
| **Top**模块      |                                                              |
| dvp_ddr3_vga_top | 例化dvp_ddr3_top、ddr3_vga_top模块，并完成相应读写逻辑的控制。 |
| **dvp_ddr3**模块 |                                                              |
| dvp_ddr3_top     | 例化dvp_rgb888、ddr3_write、dvp_ddr3_ctrl，并产生相应帧写逻辑。 |
| dvp_rgb888       | DVP数据采集模块，将8位的DVP数据转换为128位并生成相应的写请求送给ddr3_write模块，此外还需要产生场同步开始与结束信号交给dvp_ddr3_top模块产生相应帧写逻辑。 |
| ddr3_write       | 接收dvp_rgb888传来的128位数据，在dvp_ddr3_top控制逻辑下通过f2h_axi_slave完成对ps端ddr3的突发写操作。 |
| dvp_ddr3_ctrl    | dvp_ddr3控制IP，包含了状态控制寄存器，可启动IP运行并读取写状态。 |
| **ddr3_vga**模块 |                                                              |
| ddr3_vga_top     | 例化vga_ctrl、ddr3_read、ddr3_vga_ctrl，并产生相应帧读逻辑。 |
| vga_ctrl         | 从ddr3_read中获取128位数据将其转换位24位rgb数据并以vga时序输出，vga驱动时钟为5M时钟。此外还需要产生场同步开始与结束信号交给ddr3_vga_top模块产生相应帧读逻辑。 |
| ddr3_read        | 在vga_ctrl的读请求下提供相应的128位数据。在ddr3_vga_top控制逻辑下通过f2h_axi_slave完成对ps端ddr3的突发读操作。 |
| ddr3_vga_ctrl    | ddr3_vga控制IP，包含了状态控制寄存器，可启动IP运行并读取写状态。 |

图2.1.1以及表2.1.1，展示了dvp_ddr3_vga模块其组成以及各模块作用，其中，最重要的模块就是接收dvp时序的dvp_rgb888以及转换vga时序的vga_ctrl模块，以及负责使用avalon总线写入读出ddr3的ddr3_read、ddr3_write模块。

dvp_rgb888模块接收vcam传来的dvp数据，将其寄存为ddr3_write的128位数据写入ddr3_write的FIFO中，当ddr3_write的FIFO中数据深度达到突发长度16时，ddr3_write进行一次突发写，将连续16个128位数据通过f2h_axi_slave总线写入PS端ddr3的buffer中，其中ddr3_write写入是以帧为开始和结束。

ddr3_read模块通过f2h_axi_slave总线从ps端ddr3中的buffer读取dvp_ddr3模块写入的帧，一次突发读取16个128位数据，将其存储在模块内部的FIFO中，当vga_ctrl发起一次读请求时，在读时钟下，每一个时钟周期向外输出128位数据。

由于vga_ctrl在vga时钟下需要输出的是24位rgb_888像素，因此使用移位寄存器向外输出24位数据，需要满足位宽可以被24整除。读请求有效情况下，ddr3_read一个时钟输出128位数据，128无法被24整除，而384可以被24整除。因此vga_ctrl一个读请求我们需要持续三个时钟周期，也就是连续输出3个128位数据，即384位数据。

在vga时钟驱动下，每个时钟周期vga_ctrl模块向外输出24位数据，同时产生同步的vga_vsync、vga_de等同步信号。

vga时钟我们按满帧计算，一个时钟输出一个24位数据：

$400*320*30=3840000=3.84MHz$  

上述时钟不满足5M时钟，我们定义vga时序如下：

| 400*320@30 | 行同步 | 场同步 |
| ---------- | ------ | ------ |
| 同步SYNC   | 40     | 40     |
| 后沿BACK   | 0      | 20     |
| 有效VALID  | 400    | 320    |
| 前沿FRONT  | 0      | 0      |
| 周期TOTAL  | 440    | 380    |

计算实际的vga时钟如下：

$440*380*30=5016000≈5MHz$

该时钟可以保证显示帧率为满30帧。

**•dvp_ddr3_vga*端口如下：

<img src="readme.assets/image-20241202131231593.png" alt="image-20241202131231593" style="zoom:50%;" />

<img src="readme.assets/image-20241202131137873.png" alt="image-20241202131137873" style="zoom:50%;" />

图2.1.2 dvp_ddr3_vga模块端口

**•dvp_ddr3_vga****模块信号功能说明如下：

表2.1.3 dvp_ddr3_vga模块信号功能说明

| 信号                                   | 位宽 | **I/O** | 功能                                                         |
| -------------------------------------- | ---- | ------- | ------------------------------------------------------------ |
| clk                                    | 1    | I       | 系统时钟                                                     |
| reset_n                                | 1    | I       | 低电平复位                                                   |
| **dvp**时序输入接口                    |      |         |                                                              |
| dvp_pclk                               | 1    | I       | 摄像头像素时钟                                               |
| dvp_href                               | 1    | I       | 摄像头行同步信号                                             |
| dvp_vsync                              | 1    | I       | 摄像头场同步信号                                             |
| dvp_data                               | 8    | I       | 摄像头图像数据                                               |
| **dvp_slave**控制接口(avalon_mm_slave) |      |         |                                                              |
| dvp_chipselect                         | 1    | I       | 片选信号，当该信号有效时，IP 核的所有寄存器才能被访问。      |
| dvp_as_address                         | 2    | I       | 地址，该地址信号指定了 IP 核被访问的寄存器编号，通过给该信号赋予不同的值，就能选择访问不同的寄存器。 |
| dvp_as_write                           | 1    | I       | 写请求信号，当该信号有效时，writedata 端口上的数据会被写入 address 指定的寄存器中。 |
| dvp_as_writedata                       | 32   | I       | 写数据信号，当 write信号有效时，该端口上的数据会被写入 address 指定的寄存器中。 |
| dvp_as_read                            | 1    | I       | 读请求信号，当该信号有效时，readdata 端口上的数据会被写入 address 指定的寄存器中。 |
| dvp_as_readdata                        | 32   | O       | 读数据端口，当 chipselect 有效时，该端口上的值为 address 指定的寄存器中的值。 |
| **dvp_master**写接口(avalon_mm_master) |      |         |                                                              |
| dvp_master_address                     | 32   | O       | address信号代表一个字节地址                                  |
| dvp_master_write                       | 1    | O       | 置位表示一个write传输，如果存在，则需要writedata             |
| dvp_master_byteenable                  | 16   | O       | 字节使能。byteenable 中的每个比特对应于writedata和readdata中一个字节。 |
| dvp_master_writedata                   | 128  | O       | 写传输的数据                                                 |
| dvp_master_burstcount                  | 5    | O       | 突发的传输数量，dvp写突发长度为16                            |
| dvp_master_waitrequest                 | 1    | I       | 当 slave无法响应读写请求时，置位waitrequest，强制master等待； |
| **dvp_wire**测试接口                   |      |         |                                                              |
| dvp_cnt_go                             | 8    | O       | 记录hps发出的请求次数                                        |
| **vga**时序输入接口                    |      |         |                                                              |
| vga_clk                                | 1    | O       | 输出vga时钟,频率5MHz                                         |
| vga_de                                 | 1    | O       | 有效数据选通信号DE                                           |
| vga_vsync                              | 1    | O       | 输出场同步信号                                               |
| vga_hsync                              | 1    | O       | 输出行同步信号                                               |
| vga_rgb                                | 24   | O       | 输出24bit像素信息                                            |
| **vga_slave**控制接口(avalon_mm_slave) |      |         |                                                              |
| vga_chipselect                         | 1    | I       | 片选信号                                                     |
| vga_as_address                         | 2    | I       | 地址                                                         |
| vga_as_write                           | 1    | I       | 写请求信号                                                   |
| vga_as_writedata                       | 1    | I       | 写数据端口                                                   |
| vga_as_read                            | 1    | I       | 读请求信号                                                   |
| vga_as_readdata                        | 32   | O       | 读数据端口                                                   |
| **vga_master**读接口(avalon_mm_master) |      |         |                                                              |
| vga_master_address                     | 32   | O       | address信号代表一个字节地址                                  |
| vga_master_read                        | 1    | O       | 置位表示一个read传输，如果存在，则需要readdata               |
| vga_master_byteenable                  | 16   | O       | 字节使能                                                     |
| vga_master_readdata                    | 128  | I       | 写传输的数据                                                 |
| vga_master_burstcount                  | 1    | O       | 突发的传输数量，vga读突发长度为1                             |
| dvp_master_waitrequest                 | 1    | O       | 当 slave无法响应读写请求时，置位waitrequest，强制master等待； |
| vga_master_readdatavalid               | 1    | I       | 读数据有效信号                                               |

 

图2.1.2以及表2.1.3，展示了dvp_ddr3_vga模块的端口信号，并详细描述了端口信号的功能，对于细节的dvp_rgb888、vga_ctrl的时序等问题，我们将其放在2.1.2节中进行详细叙述。

**•dvp_ddr3_vga**状态控制寄存器说明如下：

| 寄存器名称          | 地址 | 位宽 | R/W  | 功能说明                                                     |
| ------------------- | ---- | ---- | ---- | ------------------------------------------------------------ |
| control             | 0    | 32   | W    | bit0:单次传输触发位，该位仅在主机写该寄存器且写入数据的bit0位为1时为高电平，否则保持低电平，对应于control_go信号。对于双buffer连续读写情况，无需ps控制时，该位无效。  bit[2:1]:预留的使能控制信号，对应于control_en。 |
| control_user_base   | 1    | 32   | W    | PL从PS侧DDR3突发读数据的物理首地址。                         |
| control_user_length | 2    | 32   | W    | 一帧图像数据量，以Byte为单位。                               |
| control_state       | 3    | 32   | W/R  | bit0:为方便PS端搬运图像，dvp连续写双buffer的状态位，利用该位PS端可读取空闲buffer;  dvp向buffer0写完一帧图像，则向control_state写1;  dvp向buffer1写完一帧图像，则向control_state写0; |

表2.1.4 dvp_ddr3状态控制寄存器说明

 

表2.1.4是针对dvp_ddr3这个模块的状态控制寄存器的说明，ddr3_vga模块和该模块类似，此处不再赘述。

上述寄存器（除control_state）只有在不使用双buffer连续传输时起用，使用双buffer连续传输时，由于需要写的两个buffer地址以及写长度在写ip时已经固定了，无需通过PS进行启动与赋地址。

#### 双Buffer连续传输

如果在PS端发起传输一帧的命令给dvp_ddr3模块以获取一帧图像，需要等待的时间是：

dvp_ddr3模块一帧传输完成时间+memcpy的时间

为了ps端获取帧图像的即时性以及减少PS端复制内存的时间开销，我们使得FPGA端不需要通过ps端进行写入。因为dvp时钟为11.5MHz，vga时钟为5MHz，而dvp一个时钟周期传输8位，vga一个时钟周期传输24位，因此vga的速度快于dvp速度，也就是dvp写完一帧的速度更慢，因此我们可以以dvp写入一帧是否完成为标志位，使用乒乓操作的原理进行双buffer连续写操作。

双buffer写状态机如下：

![image-20241202131043761](readme.assets/image-20241202131043761.png)

图2.1.3 dvp_ddr3_vga_top的读写状态机

该状态机初始状态为IDLE，启动后自动进入Wbuffer0状态，dvp_ddr3模块写入一帧给buffer0，当写完buffer0时，ddr3_write置位dvp_done表示一帧写完，使用边沿检测dvp_done上升沿得到dvp_done_posedge信号，该信号只持续一个时钟周期，检测到该信号代表一帧写完。因此写完buffer0时，转换状态为wbuffer1_rbuffer0，即dvp写buffer1，vga读buffer0。再次检测到dvp_done_posedge时，转换状态为Wbuffer0_rbuffer1，即dvp写buffer0，vga读buffer1，如此一来

就可以使得双Buffer连续传输得以实现。

使用双buffer连续传输意味着HDMI显示完全由PL端控制，无需PS端进行控制，但是由于我们需要在显示上叠加推理结果框等，想要完全实现双buffer连续传输，我们需要实现PL端绘制推理结果框。在没有实现上述模块时，我们只让dvp_ddr3由PL端控制，ddr3_vga的地址切换由PS端控制，因此buffer结构如下：

![image-20241202131057184](readme.assets/image-20241202131057184.png)

图2.1.4 普通的四buffer

使用上面结构主要是为了防止hps读取与dvp写入到同一片空间产生冲突，同时可以使得dvp写入满帧率，vga读出满帧率(hps的memcpy速度远大于显示速率)。

#### 单通道显示及推理

**•dvp_rgb888****时序**

**对于三通道：**

三通道需要传输400*320*3个字节，读取一个1个128位数据可以传16个字节，一行400个像素有1200个字节，一共需要写入75个128位数据才能传输完成400个像素。

三通道信号时序如下图：

![image-20241202131327785](readme.assets/image-20241202131327785.png)       

图2.1.5 三通道dvp_rgb888的时序

**对于单通道：**

单通道只需要传输400个字节，一共需要写入25个128位数据才能传输完成400个字节。与三通道时序不同的是，隔一个通道取一次，因此我们将原dvp_pclk进行三分频再使用该三分频时钟进行采样，在fpga工程中将该时钟约束为全局时钟，即可使得该时钟与dvp_pclk时钟同步。我们也可以使用pll产生dvp_pclk的三分频时钟，这样可以保证该时钟与dvp_pclk时钟是同步的。

单通道采样信号时序如下图：

![image-20241202131332480](readme.assets/image-20241202131332480.png)

图2.1.6 单通道dvp_rgb888的时序

**•vga_ctrl****时序图**

**对于三通道：**

由于是三通道，一个像素24位，而我们一次读取的数据位宽是128位，无法形成整除关系，因此需要将读取的128位数据凑成384位，这样384/24=16就可以被整除传输16个像素。对于一行400个像素，我们一共需要读25次384位数据，一次读请求为三个时钟周期宽。

需要注意，此处vsynv场同步信号高电平为有效，低电平为同步。

以下是第一行对应的时序图：

![image-20241202131338772](readme.assets/image-20241202131338772.png)

图2.1.7 三通道vga_ctrl的时序

**对于单通道：**

与三通道不同的是，读请求宽度为一个时钟周期，读请求只超前vga_de四个时钟周期，即请求一次读128位，不是三通道的384位，这是因为单通道一个时钟周期移位寄存器只输出8位，输出的24位像素的三个通道是一样的，因此，128位可以输出16个24位像素。其时序与三通道相似，因此不再放出时序图。

使用单通道后，每帧图像写入减少了2/3的大小，原来需要写入400*320*3，现在只需要写入400*320大小的图像。这样在DDR3中占用的空间直接减少了2/3，同时大大减轻了F2H总线的负担。

#### 使用FPGA实现图像预处理中的resize

在推理时，SSD_Monlienetv1模型要求所有输入图像都必须为同样大小，这是由于其特侦图大小以及先验框数目都必须根据输入图像大小确定，因此我们在进行推理时所有输入图像在输入网络前都必须经过resize操作将其变为统一大小300*300。根据我们的测量，400*320*3图像resize为300*300*3大小所花费的时间为7ms。在踏入了100ms的推理时间后，每一点提升都弥足珍贵，更不必说7ms的提升了，因此我们完成了将resize操作转移到PL端实现的方式完成图像预处理的并行化。

在原推理程序中，我们使用CV库中的双线性插值法对图像进行resize，因此我们为了追求与原程序效果一致，我们在PL端实现的resize操作原理也是双线性插值。

**·具体原理如下：

![image-20241202131539642](readme.assets/image-20241202131539642.png)

图2.1.8 双线性插值原理

在实际的使用中：

(1) 我们令x_ratio和y_ratio代表原始图像与缩放后图像在水平和垂直方向上的比率，即步进。

(2) 根据x_ratio和y_ratio，计算缩放后图像坐标(i,j)到到原始图像坐标的映射，其中整数部分作为原始图像的像素坐标(x,y)，小数部分作为像素灰度值的权重也就是  α和  β。实际上以行为例，本步的操作就是利用缩放后图像前i-1行乘上竖直的缩放比例y_ratio，计算缩放后图像的第i行在原始图像中的行位置，然后取其整数为原始图像的起始行，小数部分作为加权值α和  β 。

(3) 根据像素坐标(x,y)我们可以得到原始图像四邻域的像素灰度值img1(y:y+1,x:x+1)，根据 α和  β可以得到四邻域水平方向上的像素权重1-α和  α以及四邻域竖直方向上的像素权重1-β 和 β，四邻域像素与权重的乘累加和，作为放大后的图像的近似灰度值img2(i,j)。

**·根据以上原理**，我们可以实现其FPGA**版本操作:**

(1)对原始图像进行行缓存

由于双线性插值需要利用近邻4个像素进行计算并获得目标像素值，所以至少需要缓存两行像素。我们利用双端口BRAM对原始图像进行行缓存。我们需要将400*320的像素缩小为300*300，因此缓存一行原始图像像素至少需要400个BRAM地址空间，为了使得我们的IP可以在一定范围内适应输入图像大小变化，此处将BRAM一行像素空间定义为1024，同时定义BRAM最大可以存储4行像素，因此BRAM的深度为4096，而BRAM的宽度等于像素位宽也就是8。

同时我们进行双线性插值时，需要同时从BRAM 中读出近邻4个像素,我们为了降低设计难度，采用4个BRAM对图像进行行缓存，每个BRAM分别输出近邻4个像素中的其中1个。如下图所示：

![image-20241202131825034](readme.assets/image-20241202131825034.png)

图2.1.9 BRAM的存储结果

可以看到其中图像奇数行像素同时存于BRAM0和BRAM1中，偶数行像素同时存于BRAM2和BRAM3中。因此BRAM0、BRAM1、BRAM2和BRAM3分别输出左上角、右上角、左下角、右下角的像素。

将原始图像存入 BRAM之前，需要产生相应的 BRAM 地址。根据原始图像的场信号per_img_vsync和行信号 per_img_href，对原始图像进行列统计img_hs_cnt ϵ [0,C_SRC_IMG_WIDTH-1]和行统计img_vs_cnt ϵ

 [0,C_SRC_IMG_HEIGHT-1]，其中C_SRC_IMG_WIDTH和C_SRC_IMG_HEIGHT分别表示原始图像的宽度和高度。BRAM地址的计算公式如下所示，其中img_hs_cnt用于产生行内像素的地址、img_vs_cnt[2:1]用于产生不同行的基地址。
$$
\mathrm{bram}_{-}a_{-}\mathrm{waddr}=
\begin{Bmatrix}
\mathrm{img}_{-}\mathrm{vs}_{-}\mathrm{cnt}[2:1],10^{\prime}\mathrm{b}0
\end{Bmatrix}+\mathrm{img}_{-}\mathrm{hs}_{-}\mathrm{cnt}
$$
一个BRAM大小为4*1024代表4行。因此使用img_vs_cnt[2:1]产生这四行的地址，然后再使用img_hs_cnt产生其行内像素的地址。img_hs_cnt计数的行上限受输入图像dvp行有效信号限制，其上限为输入原始图像行长度。为什么使用img_vs_cnt[2:1]产生这四行的地址我们讲完写使能就知道了。

写地址解决了，接下来是写使能问题，由于BRAM0和BRAM1存储的行是奇数行，BRAM2和BRAM3存储的行是偶数行，因此我们只需要生成两个写使能信号可以对当前有效行数是奇数还是偶数进行判断即可，这很简单。因此我们的写使能信号在场同步有效以及行同步有效时，使用img_vs_cnt[0]判断当前行是奇偶，这是因为img_vs_cnt[0]在最开始第1行时为0，代表奇数行，第二行时为1代表偶数行，如此往复我们就可以通过img_vs_cnt[0]判断奇偶行。

因此我们使用img_vs_cnt[0]以及其取反信号分别可以生成奇数行和偶数行的写使能信号，在我们的代码里bram1_a_wenb为BRAM0和BRAM1的写使能，bram2_a_wenb为BRAM2和BRAM3的写使能。以上两个写使能信号分别控制两个BRAM。

而写地址信号则同时控制4个BRAM，因此如果要使用写地址信号对BRAM0和BRAM1以及BRAM2和BRAM3分别进行写地址的变化重点就在于使用img_vs_cnt[2:1]。因为两组BRAM的写使能信号是轮流有效的，因此写地址信号在前一行属于第一组BRAM，后一行属于第二组BRAM，而img_vs_cnt[2:1]每经过两行增加1，刚好与写使能信号匹配，这样两组BRAM在写入行地址时是同步变化的，这样经过8个行周期，一共有四对奇偶行就分别写入了两组BRAM。

(2)当每行像素缓存到BRAM后，将行统计img_vs_cnt作为标签存入异步FIFO中后续进行双线性插值放大算法时，会根据该标签判断BRAM中是否已经缓存了插值所需要的两行像素。

(3)在进行双线性插值算法之前，需要计算原始图像与目标图像在水平和垂直方向上的比率(即目标图像映射到原始图像的坐标步进)C_X_RATIO和C_Y_RATI O。已知原始图像的分辨率为400x320、目标图像的分辨率为300x300，且要求将比率定标为16位小数，故C_X_RATIO和C_Y_RATIO的计算结果如下:
$$
C_{-}X_{-}\mathrm{RATIO}=\mathrm{floor}\left(\frac{C_{-}SRC_{-}IMG_{-}\mathrm{WIDTH}}{C_{-}DST_{-}IMG_{-}\mathrm{WIDTH}}\times2^{16}\right)=\mathrm{floor}\left(\frac{400}{300}\times2^{16}\right)=87381C_{-}Y_{-}\mathrm{RATIO}=\mathrm{floor}\left(\frac{C_{-}SRC_{-}IMG_{-}\mathrm{HEIGHT}}{C_{-}DST_{-}IMG_{-}\mathrm{HEIGHT}}\times2^{16}\right)=\mathrm{floor}\left(\frac{320}{300}\times2^{16}\right)=69905
$$


注意C_X_RATIO和C_Y_RATIO需要使用17’进行存储

(4)目标图像的坐标(y_cnt,x_cnt)及目标图像映射到原始图像的坐标(y_dec,x_dec)均由控制器负责完成。下图所示为控制器状态机，控制器状态跳转的说明，如表所示。

![image-20241202132428262](readme.assets/image-20241202132428262.png)

图2.1.10 坐标映射的状态机控制

表2.1.5 状态跳转说明

| **状态名**   | **功能描述**                                                 |
| ------------ | ------------------------------------------------------------ |
| S_IDLE       | S_IDLE状态中，当FIFO非空时，若FIFO中的标签img_vs_cnt不为0，且目标图像最后一行像素的最近邻插值已经完成(即y_cnt==C_DST_IMG_HEIGHT)，则进入S_RD_FIFO状态;否则进入S_Y_LOAD状态 |
| S_Y_LOAD     | S_Y_LOAD状态中，对目标图像映射到原始图像的Y标y_dec进行四舍五入计算。由于y_dec[26:16]是整数部分、y_dec[15:0]是小数部分，故四舍五入结果为y_dec[26:16]+y_dec[15:0]。若结果小于等于img_vs_cnt，则说明BRAM 已经缓存了插值所需要的两行像素，进入S_BRAM_ADDR状态;否则进入S_RD_FIFO状态 |
| S_BRAM_ ADDR | S_BRAM_ ADDR状态中，生成目标图像的X坐标x_cnt、目标图像映射到原始图像的X坐标x_dec，完成后进入S_Y_INC状态 |
| S_Y_INC      | S_Y_INC状态中，生成目标图像的Y坐标y_cnt、目标图像映射到原始图像的Y坐标y_dec，若y_cnt等于目标图像最后一行C_DST_IMG_HEIGHT-1时，则进入S_RD_FIFO状态;否则，进入S_Y_LOAD状态 |
| S_RD_FIFO    | S_RD_FIFO状态中，将FIFO中的标签读出，进入S_IDLE状态          |

(5)根据(y_dec,x_dec)可以得到近邻 4个像素中左上角像素的像素级坐标整数部分(y_int_c1,x_int_c1，以及(y_dec,x_dec)与近邻4个像素的水平和垂直距离x_fra_c1、inv_x_fra_c1、y_fra_c1、inv_y_fra_c1，也就是小数部分，相当于我们上面的   和   ，   和   。

(6)将(y_int_c1,x_int_c1)转为BRAM的读地址bram_addr_c2，以及根据x_fra_c1、inv_x_fra_c1、y_fra_c1、inv_y_fra_c1计算近邻4个像素的权重frac_00_c2、frac_01_c2、frac_10_c2、frac_11_c2，分别代表左上右上左下右下角的像素。其中bram_mode_c2用于指示左上角像素位于图像奇数行或偶数行，其值为0时表示奇数行，为1时表示偶数行。

(7)根据bram_mode_c2产生近邻4个像素在4个BRAM中的读地址，注意，如果左上角像素位于奇数行，则可以将下一行取为偶数行，地址是顺着取的。如果左上角像素位于偶数行，则下一行应该为奇数行，地址需要跳一行取才行。

(8) 根据4个BRAM的读地址从BRAM中读出4个像素并映射到近邻4个像素的位置上。

(9) 得到的近邻4个像素中可能存在像素超出图像边界的情况，需要进行像素的边界复制，像素越界处理。如果边界超出图像边界，则对像素进行复制处理。

(10)将近邻4个像素与(6)中计算的各自的权重相乘后累加，得到目标像素的灰度值

(11)由于计算得到的目标像素灰度值值可能大于 255为了避免像素值越界，将灰度值大于 255 的像素，直接输出255，灰度值越界处理。

注意，以上所有操作，只有写入使用原始图像时钟，其余所有操作使用缩放图像时钟。

**·resize**模块的组成：

表2.1.6 resize模块组成

| 模块名称               | 功能描述                                                     |
| ---------------------- | ------------------------------------------------------------ |
| resize_top             | 例化rgb2gray、bilinear_interpolation、dvp_gray               |
| rgb2gray               | 将输入三通道的dvp时序转为单通道dvp时序输出，也就是将rgb转为灰度图的dvp时序输出 |
| bilinear_interpolation | 实现双线性插值，输入为灰度的400*320原图像，输出为经过resize的300*300的单通道灰度图像，其帧时序与原 |
| dvp_gray               | 就是原来的dvp_rgb888，为了防止模块冲突进行了重命名，作用是将bilinear_interpolation模块输出的dvp时序转换为ddr3_write可以接收的输入 |

**·使用resiz**后的**buffer**结构：

![image-20241202132448565](readme.assets/image-20241202132448565.png)

​                      图2.1.11 使用resize后的buffer结构

使用resize的buffer结构如上，使用单通道的resize图像大小为300*300，因此只占用buffer4和buffer5的前300*300的空间。resize与dvp是帧同步的。

#### PL侧绘制预测框

在上文中，我们为了保证推理刷新以及HDMI刷新互不影响，我们使用了两个核心分别运行两个程序并行执行达到同时完成两个任务的功能。其根本就是为了达到并行工作，既然能在PS端并行，为何我们不能在FPGA端并行呢？这与我们使用FPGA端进行resize是一样的思路。如果我们需要HDMI刷新与推理刷新完全独立的话，我们需要使用双buffer连续传输，但是阻碍我们将HDMI刷新并行到FPGA的唯一阻碍就是我们需要在HDMI显示叠加了推理结果的图像，目前我们是在PS端将推理结果绘制在原图像上再写入DDR供vga读取，因此在这里我们将PS端推理得到的推理结果传入FPGA，FPGA根据结果实时的在PL端的vga图像中叠加结果，这样PS端只用单独运行推理刷新程序，将其推理结果单方面的给FPGA即可实现绘框。

使用PL端绘制预测框，根本改进在于，完全不需要ps端进行内存复制，也就是dvp和vga是完全相关的，也就是dvp连续写，vga连续读，dvp写以及vga读地址切换直接由PL端控制，HDMI显示唯一需要与ps端进行通信的就是推理结果的通信，同时该通信是单方向的，即推理程序发给FPGA无需管是否接收。

搭建的pl_plot模块其构成如下：

表2.1.7 pl_plot模块组成

| 模块名称      | 功能描述                                                     |
| ------------- | ------------------------------------------------------------ |
| vga_ctrl      | 生成VGA有效显示像素坐标交给flag_generate，并利用传入框数控制框的显示，同时作为顶层模块例化flag_generate，并产生相应VGA时序 |
| flag_generate | 生成一个由框、标签、置信度组成的显示单元                     |
| bin2bcd       | 将传入的置信度二进制转换为BCD码给flag_generate模块选择字模   |

实现该模块的思路就是，我们以框、标签、置信度作为一个显示单元，使用一个模块对其进行控制，通过重复例化该模块，我们可以控制显示单元的个数，也就是最多可以显示多少个框、标签以及置信度显示单元，同时将各个模块输出进行或操作就可以在显示图像中显示多个显示单元。

每一次显示我们需要PS端传入的参数有框数、每个框的标签、框的位置以及该标签的置信度。一个显示单元需要显示框、标签以及置信度。其中，框的显示我们只需要传入框的左上角坐标以及右下角坐标即可绘制矩形框，标签一共有四个，而置信度的数字我们限制为四位小数，因此需要显示的字模如下：

数字：0，1，2，3，4，5，6，7，8，9，.

标签：ca_shang、zhen_kong、zhe_zhou、zang_wu

其中，对于标签我们可以直接将这四种标签直接整体转换为字模进行显示，对于置信度我们就需要将PS端传入的二进制置信度转换为五个二进制BCD码，分别对应个位以及四个小数位，通过BCD码对当前位显示的数字字模进行选择。

数字字模大小为16*16，字宽和字高设置为16*16。对于标签，我们直接生成四个标签对应的字模，无需分开生成，所有字符的高度都必须相等，因此我们需要将其生成的字模调整高度统一为16。以上字模我们将其存储在一维数组中，在综合时会被综合为ROM。

表2.1.8 标签字模

| **ca_shang**                                                 | **zhen_kong**                                                | **zhe_zhou**                                                 | **zang_wu**                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 0000000000000000;  0000000000000000;  0000000000000000;  0000000040000000;  0000000040000000;  0000000040000000;  0000000040000000;  3C3C003C5E3C5E3E;  4646006662466244;  400E0060420E4244;  4076001C4276423C;  4246004242464240;  664E0066424E427C;  383A003C423A4246;  0000000000000042;  0000FF000000007C; | 000000000000000000;  000000000000000000;  000000000000000000;  004000000040000000;  004000000040000000;  004000000040000000;  004000000040000000;  7E5E3C5E004C3C5E3E;  0C6246620058466244;  08427E420078424244;  10424042006842423C;  204242420044424240;  60426642004666427C;  7E421C420042184246;  000000000000000042;  00000000FF0000007C; | 0000000000000000;  0000000000000000;  0000000000000000;  0040000000400000;  0040000000400000;  0040000000400000;  7E40000000400000;  FE5E3C007E5E3C42;  0E6246000C624642;  1C427E0008424242;  3842400010424242;  7042420020424246;  FF4266006042666E;  FF421C007E42183A;  0000000000000000;  000000FF00000000; | 00000000000000;  00000000000000;  00000000000000;  00000000000000;  00000000000000;  00000000000000;  00000000000000;  7E3C5E3E00DB42;  0C46624400DA42;  080E4244005A42;  1076423C006A42;  20464240006646;  604E427C00646E;  7E3A424600243A;  00000042000000;  0000007CFF0000; |

表2.1.9 数字字符字模

| **小数点****.**                                              | **0**                                                        | **1**                                                        | **2**                                                        | **3**                                                        | **4**                                                        | **5**                                                        | **6**                                                        | **7**                                                        | **8**                                                        | **9**                                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 00;  00;  00;  00;  00;  00;  00;  00;  00;  00;  00;  00;  F0;  60;  00;  00; | 00;  00;  18;  7E;  7E;  E7;  E7;  E7;  E7;  E7;  E7;  E7;  7E;  3C;  00;  00; | 00;  00;  00;  1C;  3C;  7C;  7C;  1C;  1C;  1C;  1C;  1C;  1C;  1C;  00;  00; | 00;  00;  18;  7E;  FE;  E7;  07;  0E;  0E;  1C;  38;  70;  FF;  FF;  00;  00; | 00;  00;  18;  7E;  FF;  E7;  06;  1E;  1E;  07;  47;  E7;  7E;  7C;  00;  00; | 00;  00;  04;  0E;  1E;  1E;  3E;  7E;  6E;  EE;  FF;  FF;  0E;  0E;  00;  00; | 00;  00;  00;  7E;  7E;  E0;  FC;  FE;  C7;  07;  47;  C7;  FE;  7C;  00;  00; | 00;  00;  0C;  1C;  1C;  38;  78;  7E;  E7;  E7;  E7;  E7;  FF;  7E;  00;  00; | 00;  00;  00;  FF;  7F;  06;  0E;  0C;  1C;  18;  38;  38;  38;  70;  00;  00; | 00;  00;  10;  7E;  EE;  E7;  E6;  7E;  FE;  E7;  C7;  E7;  FE;  7E;  00;  00; | 00;  00;  18;  7E;  EE;  E7;  C7;  E7;  FE;  7E;  1C;  18;  38;  70;  00;  00; |

除了上述问题外，我们需要着重解决的一个问题是，从PS端得到的置信度是二进制的，我们在发送给fpga端前将其乘上10000取整发送，也就是相当于只取小数点后四位。因此我们需要提取置信度的个十百千万位用以选择在置信度区域需要显示的数字组合。

二进制转BCD我们使用“加3移位法”。

首先，我们需要得到五个BCD码，因此二进制码输入位数我们设置为16位，因为5个BCD码表示的范围为0-99999，而2的16次方为65536，对于输入小于65536的二进制数，我们都可以得到其对应的5个BCD码。

二进制转BCD转换步骤如下：

1. 对于 BCD 移位寄存器中的每 4 位的 BCD 数字，检测这个数是否大于 4。 

如果是，就在这个数字上加上一个 3。 

2. 将整个BCD寄存器向左移动一位，将输入二进制序列的最高有效位（MSB） 

移入到 BCD 寄存器的最低位（LSB）。 

3. 重复步骤 1 和步骤 2，直到所有的输入位都被使用了。

为什么检查每一个 BCD 码是否大于 4，因为如果大于 4（比如 5、6），下一步左移就要溢出了，所以加 3，等于左移后的加 6，起到十进制调节的作用。

表2.1.10 BCD时序

| 时钟  脉冲       | 移位结果（移位方向ß） | 输入的  二进制码 |       |          |
| ---------------- | --------------------- | ---------------- | ----- | -------- |
| BCD 码高位       | BCD 码次高位          | BCD 码最低位     |       |          |
|                  | 0000                  | 0000             | 0000  | 11101011 |
| 1                | 0000                  | 0000             | 0001  | 1101011  |
| 2                | 0000                  | 0000             | 0011  | 101011   |
| 3                | 0000                  | 0000             | 0111  | 01011    |
| 修正             |                       |                  | +0011 |          |
|                  | 0000                  | 0000             | 1010  | 01011    |
| 4                | 0000                  | 0001             | 0100  | 1011     |
| 5                | 0000                  | 0010             | 1001  | 011      |
| 修正             |                       |                  | +0011 |          |
|                  | 0000                  | 0010             | 1100  | 011      |
| 6                | 0000                  | 0101             | 1000  | 11       |
| 修正             |                       | +0011            | +0011 |          |
|                  | 0000                  | 1000             | 1011  | 11       |
| 7                | 0001                  | 0001             | 0111  | 1        |
| 修正             |                       |                  | +0011 |          |
|                  | 0001                  | 0001             | 1010  | 1        |
| 8                | 0010                  | 0011             | 0101  |          |
| 结果  （十进制） | 2                     | 3                | 5     |          |

在代码中，我们使用一个FSMD控制整个操作，循环访问二进制数的每一位，并且将调整电路与次态逻辑分开，使用单独的代码描述。

**·**使用resize**以及pl_plot**后的**buffer**结构：

![image-20241202132557472](readme.assets/image-20241202132557472.png)

​                                             图2.1.12 使用resize以及pl_plot后的buffer结构

使用resize以及pl_plot后的buffer结构如上，HDMI显示完全由PL端控制，因此HDMI显示buffer是PL端使用。而推理程序buffer的写入是PL端写入resize图像，大小为300*300，读出是HPS端推理程序读出resize图像用于推理。该buffer结构是最终的工程使用的结构。

**·**使用resize**以及pl_plot**的**dvp_ddr3_vga**模块框图：

![image-20241202132532844](readme.assets/image-20241202132532844.png)

图2.1.13 使用resize以及pl_plot的dvp_ddr3_vga模块框图

为了更方便的使用resize以及pl_plot模块，我们将其整合进入dvp_ddr3_vga模块。与原dvp_ddr3_vga模块相比较，增加了resize以及pl_plot模块后，对于写入ddr，增加了一个resize图像的写主机，其帧写入控制与原图像写入是一样的，同时由于是两个写主机，Avalon总线会自己进行仲裁，不需要我们进行控制先后传输。对于读ddr，仍然和原来一样，只不过我们将vga_ctrl模块替换为了pl_plot模块，该模块通过读入plot_ctrl接收的推理结果信息，将其转换为推理结果显示单元在vga显示时与原图像叠加显示。

 