//
//  File.swift
//  CodableTools
//
//  Created by boye on 2022/9/6.
//

import Foundation

struct Person: Codable {
    @Default<Int> var id: Int
    @Default<String> var name: String
    @Default<Int> var age: Int
    @Default<Double> var height: Double
    @Default<Decimal> var weight: Decimal
}
