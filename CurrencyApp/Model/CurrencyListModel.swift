//
//  CurrencyListModel.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 3/3/24.
//

import Foundation

 
struct CurrencyListModel: Codable {
    let date: String
    let base: String
    let rates: [String: Double]
}


