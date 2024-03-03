//
//  NetworkManager.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 27/2/24.
//

import Foundation

class NetworkManager{

    func getСonvertedMoney(fromCurrency: String, toCurrency: String, amount: Double, completion: @escaping (ConvertModel) -> Void) {
        // Создаем URL на основе адреса API
        guard var urlComponents = URLComponents(string: "https://api.currencybeacon.com/v1/convert") else { return }
        
        // Формируем параметры запроса
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "xsLvqVVp9NvGaqGbfm3hKFrQEIRiRrnP"),
            URLQueryItem(name: "from", value: fromCurrency),
            URLQueryItem(name: "to", value: toCurrency),
            URLQueryItem(name: "amount", value: String(amount))
        ]
        
        guard let url = urlComponents.url else { return }
        
        // Создаем URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Создаем сессию
        let session = URLSession.shared
        
        // Отправляем запрос
        let task = session.dataTask(with: request) { (data, response, error) in
            // Проверяем наличие ошибки
            if let error = error { return }
            
            // Проверяем наличие данных
            guard let data = data else { return }
            
            var resultData: ConvertModel?
            
            do {
                resultData = try JSONDecoder().decode(ConvertModel.self, from: data)
            } catch {
                print("Failed to decode data!")
            }
            
            guard let final = resultData else {
                return
            }
            completion(final)
        }
        task.resume()
    }
    
    func getCurrencyList(fromCurrency: String, completion: @escaping (CurrencyListModel?) -> Void) {
        guard var urlComponents = URLComponents(string: "https://api.currencybeacon.com/v1/latest") else { return }
        
        
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "xsLvqVVp9NvGaqGbfm3hKFrQEIRiRrnP"),
            URLQueryItem(name: "base", value: fromCurrency)
        ]
        
        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let currencyResponse = try decoder.decode(CurrencyListModel.self, from: data)
                print("Currency data received: \(currencyResponse)")
                completion(currencyResponse)
            } catch {
                print("Error decoding currency data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

}
