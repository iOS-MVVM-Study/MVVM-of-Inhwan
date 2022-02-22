//
//  LoginVC.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/02/18.
//

import UIKit

class RegistrationVC: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    private var profileImage: UIImage?
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPhotoButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullnameTextField: CustomTextField = CustomTextField(placeHolder: "Fullname")
    
    private let usernameTextField: CustomTextField = CustomTextField(placeHolder: "Username")
    
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUpDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Log In")
        button.addTarget(self, action: #selector(loginDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - func
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        
        configureGradientLayer()
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,
                                                   fullnameTextField, usernameTextField,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func configureNotificationObservers() {
        [emailTextField, passwordTextField, fullnameTextField, usernameTextField].forEach {
            $0.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        }
    }
    
    // MARK: - Actions
    
    @objc private func addPhotoButtonDidTap(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc private func loginDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        switch sender {
        case emailTextField:
            viewModel.email = sender.text
        case passwordTextField:
            viewModel.password = sender.text
        case fullnameTextField:
            viewModel.fullname = sender.text
        case usernameTextField:
            viewModel.username = sender.text
        default:
            break
        }
        
        updateForm()
    }
    
    @objc private func signUpDidTap(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text,
              let username = usernameTextField.text,
              let profileImage = profileImage else { return }
        
        let credentials = AuthCredentials(email: email, password: password,
                                          fullname: fullname, username: username,
                                          profileImage: profileImage)
        
        AuthService.registerUser(withCredential: credentials)
    }
}

// MARK: - Extensions

extension RegistrationVC: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}

extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
