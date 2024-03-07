//
//  ViewModel.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 28/2/24.
//

import Foundation


protocol ViewModelType {
    var currencyAbbreviations: [AbbreviationsModel] { get }
    func convertMoney(fromCurrency: String, toCurrency: String, amount: Double, completion: @escaping (Double) -> Void)
}

class ViewModel: ViewModelType {
    private let networkManager = NetworkManager()

    let currencyAbbreviations: [AbbreviationsModel] = [
        AbbreviationsModel(name: "USD", symbol: "$"),
        AbbreviationsModel(name: "EUR", symbol: "€"),
        AbbreviationsModel(name: "JPY", symbol: "¥"),
        AbbreviationsModel(name: "GBP", symbol: "£"),
        AbbreviationsModel(name: "AUD", symbol: "$"),
        AbbreviationsModel(name: "CAD", symbol: "$"),
        AbbreviationsModel(name: "CHF", symbol: "Fr."),
        AbbreviationsModel(name: "CNY", symbol: "¥"),
        AbbreviationsModel(name: "SEK", symbol: "kr"),
        AbbreviationsModel(name: "NZD", symbol: "$"),
        AbbreviationsModel(name: "RUB", symbol: "₽")
    ]
    
    func convertMoney(fromCurrency: String, toCurrency: String, amount: Double, completion: @escaping (Double) -> Void) {
        networkManager.getСonvertedMoney(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: amount) { response in
            // Обработка данных от сети
            print(response)
            completion(response.value)
        }
    }
}
