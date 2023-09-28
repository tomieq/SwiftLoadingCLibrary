//
//  File.swift
//  
//
//  Created by tomieq on 28/09/2023.
//

import Foundation

extension Array where Element == UInt8 {
    var pointer: UnsafePointer<UInt8> {
        var bytesPtr: UnsafePointer<UInt8>!
        self.withUnsafeBufferPointer {
            $0.baseAddress!.withMemoryRebound(to: UInt8.self, capacity: self.count) {
                bytesPtr = $0
            }
        }
        return bytesPtr
    }
}
