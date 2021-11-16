/*
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "Firestore/core/src/remote/grpc_adapt/grpc_swift_status.h"

#include <Foundation/Foundation.h>

#include "Firestore/core/src/util/string_apple.h"

#import "GRPCSwiftShim/GRPCSwiftShim-Swift.h"

namespace firebase {
namespace firestore {
namespace remote {
namespace grpc_adapt {

using firebase::firestore::util::MakeNSString;
using firebase::firestore::util::MakeString;

Status::Status() {
  GRPCStatusShim* shim = [[GRPCStatusShim alloc] init];
  code_ = StatusCode([shim errorCode]);
  msg_ = MakeString([shim errorMessage]);
}

Status::Status(StatusCode code, const std::string& msg) {
  GRPCStatusShim* shim = [GRPCStatusShim alloc];
  shim = [shim initWithStatus:code message:MakeNSString(msg)];
  code_ = StatusCode([shim errorCode]);
  msg_ = MakeString([shim errorMessage]);
}

StatusCode Status::error_code() const {
  return code_;
}

std::string Status::error_message() const {
  return msg_;
}

bool Status::ok() const {
  return code_ == StatusCode::OK;
}

}  // namespace grpc_adapt
}  // namespace remote
}  // namespace firestore
}  // namespace firebase