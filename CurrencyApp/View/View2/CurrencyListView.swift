//
//  CurrencyListView.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 3/3/24.
//

import UIKit
import SnapKit

class CurrencyListView: UIView {

    // MARK: - UI Elements
    
    let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        return gradient
    }()


    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обменный курс"
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
    let firstAmountMoney: UILabel = {
        let textField = UILabel()
        textField.text = "1"
        textField.textAlignment = .right
        return textField
    }()
    
    var amountText: String? {
        return firstAmountMoney.text
    }
    
    //символ валюты $
    let currencySymbolLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "$"
        return label
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
        label.text = "Узнать стоимость"
        label.font = UIFont(name: "Overpass-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    var pickerViewToolbar1: UIToolbar!
    
    //таблица
    let tableView: UITableView = {
        let  tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        return tableView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds // установка размеров градиента после установки размеров представления
    }

    func setupGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(red: 248 / 255, green: 169 / 255, blue: 94 / 255, alpha: 1).cgColor, UIColor(red: 151 / 255, green: 79 / 255, blue: 104 / 255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupConstraints(){
        addSubview(titleLabel)
        addSubview(firstView)
        firstView.addSubview(firstСurrency)
        firstView.addSubview(firstAmountMoney)
        firstView.addSubview(currencySymbolLabel1)
        
        
        addSubview(exchangeMoneyButton)
        exchangeMoneyButton.addSubview(exchangeMoneyLable)
        

        addSubview(tableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(20)
        }
        //MARK: - 1
        firstView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.width.equalTo(249)
            make.height.equalTo(70)
        }
        
        firstСurrency.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15) // Отступ слева
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        firstAmountMoney.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30) // Отступ справа
            make.leading.equalTo(firstСurrency.snp.trailing).offset(10) // Отступ слева от firstСurrency
        }
        
        currencySymbolLabel1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalTo(firstAmountMoney.snp.trailing).offset(0)
        }
        
        // button
        exchangeMoneyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(249)
            make.height.equalTo(64)
            make.top.equalTo(firstView.snp.bottom).offset(20)
        }
        
        exchangeMoneyLable.snp.makeConstraints { make in
            make.centerY.equalTo(exchangeMoneyButton.snp.centerY)
            make.centerX.equalTo(exchangeMoneyButton.snp.centerX)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(exchangeMoneyButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    

}
