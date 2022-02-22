//
//  CustomButton.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/02/22.
//

import UIKit

class CustomButton: UIButton {
    // MARK: - Properties
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configureUI() {
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5
        backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        setHeight(50)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        isEnabled = false
    }
}
