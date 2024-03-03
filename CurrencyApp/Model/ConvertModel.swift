//
//  ConvertModel.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 27/2/24.
//

import Foundation


struct ConvertModel: Codable {
    let timestamp: Int
    let date: String
    let from: String
    let to: String
    let amount: Double
    let value: Double
}
