// RUN: rm -rf %t && mkdir -p %t
// RUN: %target-swift-frontend -Xllvm -new-mangling-for-tests -Onone -parse-stdlib -parse-as-library  -module-name TestModule -sil-serialize-all %S/Inputs/TestModule.swift -emit-module-path %t/TestModule.swiftmodule 
// RUN: %target-swift-frontend -Xllvm -new-mangling-for-tests -O %s -I %t -emit-sil | %FileCheck %s

// DeadFunctionElimination may not remove a method from a witness table which
// is imported from another module.

import TestModule

testit(MyStruct())

// CHECK: sil_witness_table public_external [fragile] MyStruct: Proto module TestModule
// CHECK-NEXT: method #Proto.confx!1: @_T0{{.*}}confx{{.*}}FTW
