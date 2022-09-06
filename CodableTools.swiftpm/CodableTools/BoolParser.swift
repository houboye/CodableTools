//
//  BoolParser.swift
//  
//
//  Created by boye on 2022/9/6.
//

import Foundation

extension Bool {
    public enum False: DefaultValue {
        public static let defaultValue = false
        public static func fixValue(with container: SingleValueDecodingContainer) throws -> Bool {
            return try Bool.parser(from: container)
        }
    }
    public enum True: DefaultValue {
        public static let defaultValue = true
        public static func fixValue(with container: SingleValueDecodingContainer) throws -> Bool {
            return try Bool.parser(from: container)
        }
    }
    
    public static func parser(from container: SingleValueDecodingContainer) throws -> Bool {
        var boolValue: Bool
        do {
            boolValue = try container.decode(Bool.self)
        } catch {
            do {
                let intValue = Int(try container.decode(Int.self))
                if intValue > 0 {
                    boolValue = true
                } else {
                    boolValue = false
                }
            } catch {
                do {
                    let string = String(try container.decode(String.self))
                    if string.lowercased() == "true" || string.lowercased() == "yes" {
                        boolValue = true
                    } else {
                        boolValue = false
                    }
                } catch {
                    boolValue = False.defaultValue
                }
            }
        }
        return boolValue
    }
}
