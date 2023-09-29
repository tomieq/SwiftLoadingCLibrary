//
//  DynamicLibrary.swift
//  
//
//  Created by tomieq on 29/09/2023.
//

import Foundation

enum DynamicLibraryError: Error {
    case fileNotFound
    case functionNotFound(name: String)
}

class DynamicLibrary {
    private let libPath: String
    private let libHandler: UnsafeMutableRawPointer

    init(libPath: String) throws {
        self.libPath = libPath
        guard let handle = dlopen(libPath, RTLD_NOW) else {
            print("Error: Could not load dynamic lib from \(libPath)")
            throw DynamicLibraryError.fileNotFound
        }
        self.libHandler = handle
    }
    
    deinit {
        dlclose(self.libHandler)
    }
    
    func getFunc<T>(_ name: String, type: T.Type) throws -> T {
        guard let symbol = dlsym(self.libHandler, name) else {
            print("Error: Function symbol \(name) not found in library \(self.libPath)")
            throw DynamicLibraryError.functionNotFound(name: name)
        }
        return unsafeBitCast(symbol, to: T.self)
    }
}
