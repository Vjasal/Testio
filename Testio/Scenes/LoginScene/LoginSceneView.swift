import UIKit

protocol LoginSceneViewDelegate: AnyObject {
    func handleLoginButtonTapped()
}

class LoginSceneView: UIView {
    
    lazy var logoView: UIImageView = {
        let image = UIImage(named: "LoginSceneLogo")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var usernameTextField: UITextField = {
        let placeholder = "Username"
        let color = UIColor(named: "LoginSceneGray4")
        let icon = UIImage(systemName: "person.circle.fill")
        let textField = LoginSceneTextField(placeholder: placeholder, backgroundColor: color, icon: icon)
        textField.textContentType = .username
        textField.tag = 0
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let placeholder = "Password"
        let color = UIColor(named: "LoginSceneGray4")
        let icon = UIImage(systemName: "lock.circle.fill")
        let textField = LoginSceneTextField(placeholder: placeholder, backgroundColor: color, icon: icon)
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.tag = 1
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let title = "Log in"
        let color = UIColor(named: "LoginSceneBlue")
        return LoginButton(title: title, backgroundColor: color)
    }()
    
    lazy var loadingIndivator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.tintColor = UIColor(named: "LoginSceneGray2")
        return indicator
    }()
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading list"
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "LoginSceneGray2")
        return label
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    lazy var loginView = UIView()
    lazy var loadingView = UIView()
    
    lazy var backgroundView: UIImageView = {
        let image = UIImage(named: "LoginSceneBackground")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginSceneView {
    
    func setupView() {
        let textFieldStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 16
        
        let inputFormStackView = UIStackView(arrangedSubviews: [textFieldStackView, loginButton])
        inputFormStackView.axis = .vertical
        inputFormStackView.spacing = 24
        
        loginStackView.addArrangedSubview(logoView)
        loginStackView.addArrangedSubview(inputFormStackView)
        
        loginView.addSubview(loginStackView)
        loadingView.addSubview(loadingIndivator)
        loadingView.addSubview(loadingLabel)
        
        addSubview(backgroundView)
        addSubview(loginView)
        addSubview(loadingView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndivator.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 75 / 66),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginStackView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 32),
            loginStackView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -32),
            loginStackView.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndivator.widthAnchor.constraint(equalToConstant: 24),
            loadingIndivator.heightAnchor.constraint(equalTo: loadingIndivator.widthAnchor),
            loadingIndivator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingIndivator.topAnchor.constraint(equalTo: loadingView.topAnchor),
            loadingIndivator.bottomAnchor.constraint(equalTo: loadingLabel.topAnchor, constant: -8),
            loadingLabel.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor),
            loadingLabel.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor),
            loadingView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

class LoginButton: UIButton {
    
    init(title: String, fontSize: CGFloat = 17, backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = backgroundColor ?? .systemBlue
        
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoginSceneTextField: UITextField {
    
    private let focusedIconColor = UIColor(named: "LoginSceneGray1") ?? .darkGray
    private let focusedPlaceholderColor = UIColor(named: "LoginSceneGray3") ?? .lightGray
    
    private let unfocusedIconColor = UIColor(named: "LoginSceneGray2") ?? .gray
    private let unfocusedPlaceholderColor = UIColor(named: "LoginSceneGray2") ?? .gray
    
    private let defaultTintColor = UIColor(named: "LoginSceneBlue") ?? .systemBlue
    private let defaultTextColor = UIColor(named: "LoginSceneGray1") ?? .darkGray

    init(placeholder: String, fontSize: CGFloat = 17, padding: CGFloat = 9, backgroundColor: UIColor? = nil, icon: UIImage? = nil) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = backgroundColor ?? .white
        
        self.textColor = defaultTextColor
        self.tintColor = defaultTintColor
        
        self.placeholder = placeholder
        
        self.leftViewMode = .always
        self.rightViewMode = .always
        
        if let icon = icon {
            let imageView = UIImageView(image: icon)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            let view = UIView()
            view.addSubview(imageView)
            self.leftView = view
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: view.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        } else {
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        }
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        
        updateView(hasFocus: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        updateView(hasFocus: true)
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        updateView(hasFocus: false)
        return super.resignFirstResponder()
    }
    
    private func updateView(hasFocus: Bool) {
        if let placeholder = self.placeholder {
            let placeholderColor = hasFocus ? focusedPlaceholderColor : unfocusedPlaceholderColor
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
        }
        
        if self.text?.isEmpty == true, let imageView = self.leftView?.subviews.first as? UIImageView {
            let iconColor = hasFocus ? focusedIconColor : unfocusedIconColor
            imageView.tintColor = iconColor
        }
    }
}
