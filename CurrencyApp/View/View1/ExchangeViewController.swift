//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 24/1/24.
//

import UIKit
import SnapKit

class ExchangeViewController: UIViewController, ViewModelType {
    var currencyAbbreviations: [AbbreviationsModel] = []
    
    
    func convertMoney(fromCurrency: String, toCurrency: String, amount: Double, completion: @escaping (Double) -> Void) {
        viewModel.convertMoney(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: amount, completion: completion)
    }
    
    
    var exchangeView = ExchangeView()
    

    
    
    let networkManager = NetworkManager()
    let viewModel = ViewModel()
    
    //let currencyAbbreviations = viewModel.currencyAbbreviations
    
    override func loadView() {
        view = exchangeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTarget()
        
        exchangeView.firstСurrency.inputView = exchangeView.pickerView
        exchangeView.secondСurrency.inputView = exchangeView.pickerView
        exchangeView.pickerView.delegate = self
        exchangeView.pickerView.dataSource = self
        
        //Вызов метода fetchCurrencyData с указанием базовой валюты
        networkManager.getCurrencyList(fromCurrency: "EUR") { currencyResponse in
            if let currencyResponse = currencyResponse {
                // Ваши действия с полученными данными currencyResponse здесь
                // Например, обновление интерфейса с использованием полученных данных
                print("Received currency data: \(currencyResponse)")
            } else {
                // Обработка ситуации, если данные не были получены
                print("Failed to fetch currency data")
            }
        }

    }
    
    func setupTarget(){
        exchangeView.exchangeMoneyButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
        
        
        // Создайте панель для управления пикером.
        exchangeView.pickerViewToolbar1 = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerDoneButtonTapped1))
        exchangeView.pickerViewToolbar1.setItems([doneButton1], animated: false)
        
        
        exchangeView.pickerViewToolbar2 = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerDoneButtonTapped2))
        exchangeView.pickerViewToolbar2.setItems([doneButton2], animated: false)
        
        // Установите панель как inputAccessoryView текстового поля.
        exchangeView.firstСurrency.inputAccessoryView = exchangeView.pickerViewToolbar1
        exchangeView.secondСurrency.inputAccessoryView = exchangeView.pickerViewToolbar2
    }
    
    @objc func pickerDoneButtonTapped1() {
        // Скрыть пикер после нажатия кнопки "Готово".
        exchangeView.firstСurrency.resignFirstResponder()
        // Вставить выбранное значение из пикера в текстовое поле.
        let selectedValue = exchangeView.pickerView.selectedRow(inComponent: 0) // Получите выбранное значение из пикера
        exchangeView.firstСurrency.text = viewModel.currencyAbbreviations[selectedValue].name // Вставьте его обратно в текстовое поле
        // Установите символ выбранной валюты в лейбл
        exchangeView.currencySymbolLabel1.text = viewModel.currencyAbbreviations[selectedValue].symbol
    }
    
    @objc func pickerDoneButtonTapped2() {
        // Скрыть пикер после нажатия кнопки "Готово".
        //exchangeView.firstСurrency.resignFirstResponder()
        exchangeView.secondСurrency.resignFirstResponder()
        // Вставить выбранное значение из пикера в текстовое поле.
        let selectedValue = exchangeView.pickerView.selectedRow(inComponent: 0) // Получите выбранное значение из пикера
        exchangeView.secondСurrency.text = viewModel.currencyAbbreviations[selectedValue].name // Вставьте его обратно в текстовое поле
        // Установите символ выбранной валюты в лейбл
        exchangeView.currencySymbolLabel2.text = viewModel.currencyAbbreviations[selectedValue].symbol
        
    }
    
    @objc private func convertButtonTapped() {
        guard let fromCurrency = exchangeView.fromCurrencyText,
              let toCurrency = exchangeView.toCurrencyText,
              let amount = exchangeView.amountText else { return }
        
        convertMoney(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: Double(amount) ?? 0.0) { convertedValue in
            DispatchQueue.main.async { [weak self] in
                self?.exchangeView.secondAmountMoney.text = String(format: "%.2f", convertedValue)
            }
        }
    }
}

extension ExchangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // В вашем случае, вероятно, один компонент для списка валют.
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currencyAbbreviations.count // Количество элементов в списке валют.
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencyAbbreviations[row].name // Текст для каждого элемента в списке валют.
    }
}
