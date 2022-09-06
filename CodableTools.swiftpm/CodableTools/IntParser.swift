//
//  File.swift
//  CodableTools
//
//  Created by boye on 2022/9/6.
//

import Foundation


extension Int: DefaultValue {
    public static let defaultValue = 0
    public static func fixValue(with container: SingleValueDecodingContainer) throws -> Int {
        var intValue: Int
        do {
            intValue = try container.decode(Int.self)
        } catch {
            do {
                intValue = Int(try container.decode(String.self)) ?? defaultValue
            } catch {
                intValue = defaultValue
            }
        }
        return intValue
    }
}
