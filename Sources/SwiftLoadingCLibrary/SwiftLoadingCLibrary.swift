import Foundation

@main
public struct SwiftLoadingCLibrary {

    public static func main() {
        let workingDir = FileManager.default.currentDirectoryPath
        print("Working in \(workingDir)")
        let libPath = "\(workingDir)/cLib/libsample.so"
        
        do {
            let dynamicLib = try DynamicLibrary(libPath: libPath)
            
            // MARK: invoke function returning integer
            let getNumber = try dynamicLib.getFunc("getNumber", type: (@convention(c) () -> CInt).self)
            print("result: \(getNumber())")
            
            
            // MARK:  invoke function not returninh anything
            let noReturn = try dynamicLib.getFunc("noReturn", type: (@convention(c) () -> Void).self)
            noReturn()

            // MARK:  invoke function with parameter [UInt8]
            let acceptBytes = try dynamicLib.getFunc("acceptBytes", type: (@convention(c) (UnsafePointer<UInt8>) -> Void).self)
            let bytes: [UInt8] = Array("abc".data(using: .utf8)!)
            acceptBytes(bytes.pointer)
            
            
            let initParameter = try dynamicLib.getFunc("initParameter", type: (@convention(c) (UnsafePointer<UInt8>) -> Void).self)

            let vector = [UInt8](repeating: 0, count: 10)
            print("vector before: \(vector)")
            initParameter(vector)
            print("vector after: \(vector)")
            
            // MARK: invoke function that returns pointer to C struct
            let getStructPointer = try dynamicLib.getFunc("getStructPointer", type: (@convention(c) () -> UnsafeRawPointer).self)
            
            struct CStruct {
                var data1: UInt8 = 0
                var data2: UInt8 = 0
                var data3: UInt8 = 0
            }
            let pointer = getStructPointer()
            let objectArray = pointer.bindMemory(to: CStruct.self, capacity: 1)
            let cstruct = objectArray[0]
            
            print("d1: \(cstruct.data1)")
            print("d2: \(cstruct.data2)")
            print("d3: \(cstruct.data3)")
        } catch {
            
        }
    }
}
