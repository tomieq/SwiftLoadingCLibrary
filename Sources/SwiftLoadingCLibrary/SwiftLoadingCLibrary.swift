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
            print("getNumber returned: \(getNumber())")
            
            
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
            
            print("getStructPointer d1: \(cstruct.data1)")
            print("getStructPointer d2: \(cstruct.data2)")
            print("getStructPointer d3: \(cstruct.data3)")
            
            typealias CalculateFunction = @convention(c) (
                UnsafePointer<UInt32>,
                UnsafeMutableRawPointer,
                UnsafeMutableRawPointer,
                UnsafePointer<UInt8>
            ) -> UInt32

            let calculate = try dynamicLib.getFunc("calculate", type:CalculateFunction.self)
            let table: [UInt32] = (100...111).map { UInt32($0) }
            var a: TomInt = (0, 1, 0, 1) // Inicjalizacja przez C
            var b = TomPair(x: (0, 2, 0, 2), y: (0, 5, 0, 5)) // Inicjalizacja przez C
            let c: [UInt8] = [5, 6, 7, 8]
            let calculation = calculate(table, &a, &b, c)
            print("calculation: \(calculation)")

        } catch {
            
        }
    }
}

typealias TomInt = (UInt32, UInt32, UInt32, UInt32) // Jawne określenie rozmiaru
struct TomPair {
    var x: TomInt
    var y: TomInt
}
