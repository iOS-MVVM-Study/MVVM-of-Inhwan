//
//  AuthenticationViewModel.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/02/22.
//

import UIKit

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel {
    
}
