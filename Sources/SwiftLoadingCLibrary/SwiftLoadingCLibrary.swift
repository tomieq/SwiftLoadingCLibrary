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
        
        dlclose(handle)
    }
}
