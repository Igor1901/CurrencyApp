//
//  ExchangeView.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 23/2/24.
//

import UIKit
import SnapKit

class ExchangeView: UIView {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Конвертер валют"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    //первое облачко
    private let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -3, height: 5)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 6
        return view
    }()

    //Валюта 1 firstСurrency
    
    let firstСurrency: UITextField = {
        let textField = UITextField()
        textField.text = "USD"
        textField.textAlignment = .left
        return textField
    }()
    
    var fromCurrencyText: String? {
        return firstСurrency.text
    }
    
    //firstAmountMoney
    let firstAmountMoney: UITextField = {
        let textField = UITextField()
        textField.text = "0"
        textField.textAlignment = .right
        return textField
    }()
    
    var amountText: String? {
        return firstAmountMoney.text
    }
    
    //второе облачко
    private let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -3, height: 5)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 6
        return view
    }()

    //Валюта 2 firstСurrency
    
    let secondСurrency: UITextField = {
        let textField = UITextField()
        textField.text = "RUB"
        textField.textAlignment = .left
        return textField
    }()
    
    var toCurrencyText: String? {
        return secondСurrency.text
    }
    
    //second AmountMoney
    let secondAmountMoney: UITextField = {
        let textField = UITextField()
        textField.text = "0"
        textField.textAlignment = .right
        return textField
    }()
    // button
    let exchangeMoneyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: -3, height: 5)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 6
        return button
    }()
    
    let exchangeMoneyLable:UILabel = {
        let label = UILabel()
        label.text = "Поменять деньги"
        label.font = UIFont(name: "Overpass-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    var pickerViewToolbar1: UIToolbar!

    var pickerViewToolbar2: UIToolbar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints(){
        addSubview(titleLabel)
        addSubview(firstView)
        firstView.addSubview(firstСurrency)
        firstView.addSubview(firstAmountMoney)
        
        addSubview(secondView)
        secondView.addSubview(secondСurrency)
        secondView.addSubview(secondAmountMoney)
        
        addSubview(exchangeMoneyButton)
        exchangeMoneyButton.addSubview(exchangeMoneyLable)
        

        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(20)
        }
        //MARK: - 1
        firstView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(80)
        }
        
        firstСurrency.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10) // Отступ слева
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        firstAmountMoney.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-25) // Отступ справа
            make.leading.equalTo(firstСurrency.snp.trailing).offset(10) // Отступ слева от firstСurrency
        }
        //MARK: - 2
        secondView.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(80)
        }
        
        secondСurrency.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10) // Отступ слева
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        secondAmountMoney.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10) // Отступ справа
            make.leading.equalTo(secondСurrency.snp.trailing).offset(10) // Отступ слева от firstСurrency
        }
        // button
        exchangeMoneyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(249)
            make.height.equalTo(64)
            make.top.equalTo(secondView.snp.bottom).offset(20)
        }
        
        exchangeMoneyLable.snp.makeConstraints { make in
            make.centerY.equalTo(exchangeMoneyButton.snp.centerY)
            make.centerX.equalTo(exchangeMoneyButton.snp.centerX)
        }
    }
    
    

}
