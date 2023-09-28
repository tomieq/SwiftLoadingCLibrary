import Foundation

@main
public struct SwiftLoadingCLibrary {

    public static func main() {
        let workingDir = FileManager.default.currentDirectoryPath
        print("Working in \(workingDir)")
        
        guard let handle = dlopen("\(workingDir)/cLib/libsample.so", RTLD_NOW) else {
            print("Could not load dynamic lib!")
            return
        }
        defer {
            dlclose(handle)
        }
        
        /// invoke function returning integer
        let getNumberSym = dlsym(handle, "getNumber")
        typealias getNumberType = @convention(c) () -> CInt
        let getNumber = unsafeBitCast(getNumberSym, to: getNumberType.self)
        let result = getNumber()
        print("result: \(result)")
        
        ///  invoke function not returninh anything
        let noReturnSym = dlsym(handle, "noReturn")
        typealias noReturnType = @convention(c) () -> Void
        let noReturn = unsafeBitCast(noReturnSym, to: noReturnType.self)
        noReturn()
        
        ///  invoke function with parameter [UInt8]
        let acceptBytesSym = dlsym(handle, "acceptBytes")
        typealias acceptBytesType = @convention(c) (UnsafePointer<UInt8>) -> Void
        let acceptBytes = unsafeBitCast(acceptBytesSym, to: acceptBytesType.self)
        let bytes: [UInt8] = Array("abc".data(using: .utf8)!)
        acceptBytes(bytes.pointer)
        
        /// invoke function that inits data in passed parameter
        let initParameterSym = dlsym(handle, "initParameter")
        typealias initParameterType = @convention(c) (UnsafePointer<UInt8>) -> Void
        let initParameter = unsafeBitCast(initParameterSym, to: initParameterType.self)

        let vector = [UInt8](repeating: 0, count: 10)
        print("vector before: \(vector)")
        initParameter(vector)
        print("vector after: \(vector)")

    }
}
