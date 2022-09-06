//
//  UIntParser.swift
//  
//
//  Created by boye on 2022/9/6.
//

import UIKit

extension UInt: DefaultValue {
    public static let defaultValue: UInt = 0
    public static func fixValue(with container: SingleValueDecodingContainer) throws -> UInt {
        var intValue: UInt
        do {
            intValue = try container.decode(UInt.self)
        } catch {
            do {
                intValue = UInt(try container.decode(Int.self))
            } catch {
                do {
                    intValue = UInt(try container.decode(String.self)) ?? defaultValue
                } catch {
                    intValue = defaultValue
                }
            }
        }
        return intValue
    }
}
