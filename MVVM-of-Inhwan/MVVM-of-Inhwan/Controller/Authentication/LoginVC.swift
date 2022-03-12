import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationComplete()
}

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    private let loginButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password", secondPart: "Get help signing in.")
        return button
    }()

    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(signUpDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 80, width: 120)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Actions
    
    @objc private func signUpDidTap(_ sender: UIButton) {
        let nextVC = RegistrationVC()
        nextVC.delegate = delegate
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc private func loginButtonDidTap(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        Task {
            do {
                try await AuthService.logUserIn(withEmail: email, password: password)
                delegate?.authenticationComplete()
                self.dismiss(animated: true, completion: nil)
            } catch let error {
                print("DEBUG: Failed to login user \(error.localizedDescription)")
                return
            }
        }
    }
}

// MARK: - Extensions

extension LoginVC: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}
