//
//  DecimalParser.swift
//  
//
//  Created by boye on 2022/9/6.
//

import UIKit

extension Decimal: DefaultValue {
    public static let defaultValue = Decimal(0)
    public static func fixValue(with container: SingleValueDecodingContainer) throws -> Decimal {
        var decimal: Decimal
        do {
            decimal = try container.decode(Decimal.self)
        } catch {
            do {
                decimal = Decimal(Int(try container.decode(Int.self)))
            } catch {
                do {
                    decimal = Decimal(string: try container.decode(String.self)) ?? defaultValue
                } catch {
                    decimal = defaultValue
                }
            }
        }
        return decimal
    }
}
