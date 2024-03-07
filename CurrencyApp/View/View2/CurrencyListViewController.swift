//
//  CurrencyListViewController.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 3/3/24.
//

import UIKit
import SnapKit

class CurrencyListViewController: UIViewController {

    var listView = CurrencyListView()
    var currencyListModel: CurrencyListModel?
    var multiplier: Double = 100.0 // Множитель для указания суммы для перевода
    
    var currencyAbbreviations: [AbbreviationsModel] = [
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
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTarget()
        
        listView.firstСurrency.inputView = listView.pickerView
        
        listView.pickerView.delegate = self
        listView.pickerView.dataSource = self
        
        listView.tableView.dataSource = self
        listView.tableView.delegate = self

        listView.exchangeMoneyButton.addTarget(self, action: #selector(exchangeMoneyButtonTapped), for: .touchUpInside)
        
        // Пример добавления тестовых данных
        listView.tableView.reloadData()
    }
    func setupTarget(){
        //listView.exchangeMoneyButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
        
        
        // Создайте панель для управления пикером.
        listView.pickerViewToolbar1 = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerDoneButtonTapped1))
        listView.pickerViewToolbar1.setItems([doneButton1], animated: false)
        
        
        // Установите панель как inputAccessoryView текстового поля.
        listView.firstСurrency.inputAccessoryView = listView.pickerViewToolbar1
      
    }
    
    @objc func pickerDoneButtonTapped1() {
        // Скрыть пикер после нажатия кнопки "Готово".
        listView.firstСurrency.resignFirstResponder()
        // Вставить выбранное значение из пикера в текстовое поле.
        let selectedValue = listView.pickerView.selectedRow(inComponent: 0) // Получите выбранное значение из пикера
        listView.firstСurrency.text = currencyAbbreviations[selectedValue].name // Вставьте его обратно в текстовое поле
        // Установите символ выбранной валюты в лейбл
        listView.currencySymbolLabel1.text = currencyAbbreviations[selectedValue].symbol
    }
    
    @objc func exchangeMoneyButtonTapped() {
        guard let fromCurrency = listView.firstСurrency.text else { return }
        
        
        NetworkManager().getCurrencyList(fromCurrency: fromCurrency) { [weak self] currencyListModel in
            guard let self = self, let currencyListModel = currencyListModel else { return }
            
            
            // Обновляем модель данных для таблицы
            self.currencyListModel = currencyListModel
            

            // Сортируем данные перед обновлением таблицы
            let sortedRates = currencyListModel.rates.sorted { $0.key < $1.key }
            self.currencyListModel?.rates = Dictionary(uniqueKeysWithValues: sortedRates)

            
            DispatchQueue.main.async {
                self.listView.tableView.reloadData() // Обновляем интерфейс
            }
        }
    }
}

extension CurrencyListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyListModel?.rates.count ?? 0 // Возвращаем количество элементов в массиве
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as! CurrencyTableViewCell
                
        // Получаем данные для текущей строки
        guard let currencyListModel = currencyListModel else { return cell }
        let currency = Array(currencyListModel.rates.keys)[indexPath.row]
        let rate = (currencyListModel.rates[currency] ?? 0.0) * multiplier // Умножаем курс на множитель
        
        // Конфигурируем ячейку данными
        cell.configure(with: currency, rate: rate)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Устанавливаем высоту ячейки
    }
}

extension CurrencyListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let amount = Double(text) {
            multiplier = amount // Обновляем множитель по завершении редактирования текстового поля
            print("wkfgoejroigjilejglierjogjerogjioerjgoi", multiplier, amount)
        }
    }
}
