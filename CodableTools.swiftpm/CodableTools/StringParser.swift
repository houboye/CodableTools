//
//  File.swift
//  CodableTools
//
//  Created by boye on 2022/9/6.
//

import Foundation

extension String: DefaultValue {
    public static let defaultValue = ""
    public static func fixValue(with container: SingleValueDecodingContainer) throws -> String {
        var string: String?
        do {
            string = try container.decode(String.self)
        } catch {
            do {
                string = String(try container.decode(Int.self))
            } catch {
                do {
                    string = String(try container.decode(Double.self))
                } catch {
                    string = defaultValue
                }
            }
        }
        return string ?? defaultValue
    }
}
