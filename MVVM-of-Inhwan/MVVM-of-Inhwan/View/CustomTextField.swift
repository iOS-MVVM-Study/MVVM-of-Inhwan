//
//  CustomTextField.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/02/18.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - intializer
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        configureUI(placeholder: placeholder ?? "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configureUI(placeholder: String) {
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .default
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
}
