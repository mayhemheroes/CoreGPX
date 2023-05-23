#if canImport(Darwin)
import Darwin.C
#elseif canImport(Glibc)
import Glibc
#elseif canImport(MSVCRT)
import MSVCRT
#endif

import Foundation
import CoreGPX

@_cdecl("LLVMFuzzerTestOneInput")
public func test(_ start: UnsafeRawPointer, _ count: Int) -> CInt {
    let fdp = FuzzedDataProvider(start, count)
    let parse_str = fdp.ConsumeRemainingString()

    if let parse_data = parse_str.data(using: .utf8) {
        GPXParser(withData: parse_data).parsedData()
    }
    return 0;
}