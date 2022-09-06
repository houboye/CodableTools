//
//  FloatParser.swift
//  
//
//  Created by boye on 2022/9/6.
//

import UIKit

extension Float: DefaultValue {
    public static let defaultValue: Float = 0.0
    public static func fixValue(with container: SingleValueDecodingContainer) throws -> Float {
        var floatValue: Float
        do {
            floatValue = try container.decode(Float.self)
        } catch {
            do {
                floatValue = Float(try container.decode(Int.self))
            } catch {
                do {
                    floatValue = Float(try container.decode(String.self)) ?? defaultValue
                } catch {
                    floatValue = defaultValue
                }
            }
        }
        return floatValue
    }
}
