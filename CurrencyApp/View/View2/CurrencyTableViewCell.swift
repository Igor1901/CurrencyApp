//
//  CurrencyTableViewCell.swift
//  CurrencyApp
//
//  Created by Игорь Пачкин on 3/3/24.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "CurrencyCell"
    
    // MARK: - UI Elements
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.backgroundColor = .clear
        label.textAlignment = .left
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = .clear
        label.textAlignment = .right
        return label
    }()
    
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubview(currencyLabel)
        addSubview(rateLabel)
        
        // Add constraints here
        
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10) // Прижимаем к левому краю с отступом 10 пикселей
            make.bottom.equalToSuperview().offset(-10) // Центрируем вертикально
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10) // Прижимаем к правому краю с отступом 10 пикселей
            make.bottom.equalToSuperview().offset(-10) // Центрируем вертикально
        }
    }
    
    // MARK: - Configuration
    
    func configure(with currency: String, rate: Double) {
        currencyLabel.text = currency
        rateLabel.text = String(format: "%.2f", rate)
    }
}
