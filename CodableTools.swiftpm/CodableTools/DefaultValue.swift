//
//  DefaultValue.swift
//  
//
//  Created by boye on 2022/9/6.
//

import UIKit

public protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
    static func fixValue(with container: SingleValueDecodingContainer) throws -> Value
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Default: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(T.Value.self) {
            wrappedValue = value
        } else {
            wrappedValue = try T.fixValue(with: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: Default<T>.Type,
        forKey key: Key
    ) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

