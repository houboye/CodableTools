//
//  File.swift
//  CodableTools
//
//  Created by boye on 2022/9/6.
//

import Foundation

public enum CodableError: Error {
    case notMatchResultType
    case canNotTransformToJsonString(String.Encoding)
    case canNotTransformToData(String.Encoding)
}

public class CodableTools {
    
    public static func transformToAnyJson<T: Codable>(with aCodable: T) throws -> Any {
        let jsonData = try JSONEncoder().encode(aCodable)
        return try JSONSerialization.jsonObject(with: jsonData)
    }
    
    public static func transformToJsonMap<T: Codable>(with aCodable: T) throws -> [AnyHashable: Any] {
        if let dictionary = try transformToAnyJson(with: aCodable) as? [AnyHashable: Any] {
            return dictionary
        } else {
            throw CodableError.notMatchResultType
        }
    }
    
    public static func transformToJsonArray<T: Codable>(with aCodable: T) throws -> [Any] {
        if let array = try transformToAnyJson(with: aCodable) as? [Any] {
            return array
        } else {
            throw CodableError.notMatchResultType
        }
    }
    
    public static func transformToJsonString<T: Codable>(with aCodable: T, encoding: String.Encoding = .utf8) throws -> String {
        let jsonData = try JSONEncoder().encode(aCodable)
        if let result = String(data: jsonData, encoding: encoding) {
            return result
        } else {
            throw CodableError.canNotTransformToJsonString(encoding)
        }
    }
    
    public static func jsonDataToModel<T: Codable>(_ jsonData: Data) throws -> T {
        let result = try JSONDecoder().decode(T.self, from: jsonData)
        return result
    }
    
    public static func mapToModel<T: Codable>(_ map: [AnyHashable: Any], options: JSONSerialization.WritingOptions) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: map, options: options)
        return try jsonDataToModel(jsonData)
    }
    
    public static func arrayToModel<T: Codable>(_ array: [Any], options: JSONSerialization.WritingOptions) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: array, options: options)
        return try jsonDataToModel(jsonData)
    }
    
    public static func jsonStringToModel<T: Codable>(_ jsonString: String, using encoding: String.Encoding) throws -> T {
        guard let jsonData = jsonString.data(using: encoding) else {
            throw CodableError.canNotTransformToData(encoding)
        }
        return try jsonDataToModel(jsonData)
    }
}
