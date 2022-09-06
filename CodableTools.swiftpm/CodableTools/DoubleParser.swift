//
//  DoubleParser.swift
//  
//
//  Created by boye on 2022/9/6.
//

import UIKit

extension Double: DefaultValue {
    public static let defaultValue = 0.0
    public static func fixValue(with container: SingleValueDecodingContainer) throws -> Double {
        var doubleValue: Double
        do {
            doubleValue = try container.decode(Double.self)
        } catch {
            do {
                doubleValue = Double(try container.decode(Int.self))
            } catch {
                do {
                    doubleValue = Double(try container.decode(String.self)) ?? 0
                } catch {
                    doubleValue = defaultValue
                }
            }
        }
        return doubleValue
    }
}
