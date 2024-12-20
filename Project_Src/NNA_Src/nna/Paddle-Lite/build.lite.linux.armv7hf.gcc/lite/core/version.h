// Copyright (c) 2019 PaddlePaddle Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#pragma once

#include <string>
#include "lite/utils/replace_stl/stream.h"
#include "lite/utils/string.h"

namespace paddle {
namespace lite {

static constexpr int MAJOR_COEFF = 1000000;
static constexpr int MINOR_COEFF = 1000;
static constexpr int PATCH_COEFF = 1;

static std::string paddlelite_commit() {
  return "";
}

static std::string paddlelite_branch() {
  return "";
}

static std::string paddlelite_tag() {
  return "";
}

static std::string version() {
  STL::stringstream ss;

  std::string tag = paddlelite_tag();
  if (tag.empty()) {
    ss << paddlelite_commit();
  } else {
    ss << tag;
  }

  return ss.str();
}

static int64_t int_version(const std::string& version) {
  const std::vector<std::string> vec = Split(version, ".");
  if (vec.size() == 3) {
    return atoi(vec[0].c_str()) * MAJOR_COEFF +
           atoi(vec[1].c_str()) * MINOR_COEFF +
           atoi(vec[2].c_str()) * PATCH_COEFF;
  }
  return -1;
}

}  // namespace lite
}  // namespace paddle
