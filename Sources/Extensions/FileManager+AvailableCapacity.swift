//
//  FileManager+AvailableCapacity.swift
//  Tiercel
//
//  Created by Daniels on 2019/1/22.
//  Copyright © 2019 Daniels. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension FileManager: TiercelCompatible {}
extension TiercelWrapper where Base: FileManager {
    public var freeDiskSpaceInBytes: Int64 {
        // volumeAvailableCapacityForImportantUsage is iOS only; the plain capacity key exists on tvOS too.
        let key: URLResourceKey = {
#if os(tvOS)
            return .volumeAvailableCapacityKey
#else
            return .volumeAvailableCapacityForImportantUsageKey
#endif
        }()
        guard let values = try? URL(fileURLWithPath: NSHomeDirectory()).resourceValues(forKeys: [key]) else { return 0 }
#if os(tvOS)
        return Int64(values.volumeAvailableCapacity ?? 0)
#else
        return values.volumeAvailableCapacityForImportantUsage ?? 0
#endif
    }
}

