//
//  ViewModel.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 28/2/24.
//

import Foundation


protocol ViewModelType {
    func convertMoney(fromCurrency: String, toCurrency: String, amount: Double, completion: @escaping (Double) -> Void)
}

class ViewModel: ViewModelType {
    private let networkManager = NetworkManager()

    func convertMoney(fromCurrency: String, toCurrency: String, amount: Double, completion: @escaping (Double) -> Void) {
        networkManager.getСonvertedMoney(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: amount) { response in
            // Обработка данных от сети
            print(response)
            completion(response.value)
        }
    }
}
