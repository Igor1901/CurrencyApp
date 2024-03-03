//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 24/1/24.
//

import UIKit
import SnapKit

class ExchangeViewController: UIViewController, ViewModelType {
    
    func convertMoney(fromCurrency: String, toCurrency: String, amount: Double, completion: @escaping (Double) -> Void) {
        viewModel.convertMoney(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: amount, completion: completion)
    }
    
    
    var exchangeView = ExchangeView()
    
    /*
    let currencyAbbreviations = [
        "USD", "EUR", "JPY", "GBP", "AUD",
        "CAD", "CHF", "CNY", "SEK", "NZD",
        "RUB"
    ]*/

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
    
    let networkManager = NetworkManager()
    let viewModel = ViewModel()
    
    
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
        exchangeView.firstСurrency.text = currencyAbbreviations[selectedValue].name // Вставьте его обратно в текстовое поле
    }
    
    @objc func pickerDoneButtonTapped2() {
        // Скрыть пикер после нажатия кнопки "Готово".
        exchangeView.firstСurrency.resignFirstResponder()
        // Вставить выбранное значение из пикера в текстовое поле.
        let selectedValue = exchangeView.pickerView.selectedRow(inComponent: 0) // Получите выбранное значение из пикера
        exchangeView.secondСurrency.text = currencyAbbreviations[selectedValue].name // Вставьте его обратно в текстовое поле
    }
    
    @objc private func convertButtonTapped() {
        guard let fromCurrency = exchangeView.fromCurrencyText,
              let toCurrency = exchangeView.toCurrencyText,
              let amount = exchangeView.amountText else { return }
        
        convertMoney(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: Double(amount) ?? 0.0) { convertedValue in
            DispatchQueue.main.async { [weak self] in
                self?.exchangeView.secondAmountMoney.text = String(convertedValue)
            }
        }
    }
}

extension ExchangeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // В вашем случае, вероятно, один компонент для списка валют.
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyAbbreviations.count // Количество элементов в списке валют.
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyAbbreviations[row].name // Текст для каждого элемента в списке валют.
    }
}
