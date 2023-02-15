import UIKit

protocol LoginSceneViewControllerProtocol: AnyObject {
    var router: LoginSceneRouterProtocol? { get set }
    var interactor: LoginSceneInteractorProtocol? { get set }
    var loginView: LoginSceneView? { get set }
    
    func showLoadingServerListIndicator()
    func hideLoadingServerListIndicator()
    func handleLoginSuccess(token: String)
    func showLoginErrorAlert(_ error: Error)
    func handleServerListReceived(_ servers: [Server])
    func showServerListError(_ error: Error)
}

class LoginSceneViewController: UIViewController, LoginSceneViewControllerProtocol {
    
    var router: LoginSceneRouterProtocol?
    var interactor: LoginSceneInteractorProtocol?
    var loginView: LoginSceneView?
    
    override func loadView() {
        super.loadView()
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.setupLayout()
        loginView?.loginButton.addTarget(self, action: #selector(handleLoginButtonTapped), for: .touchUpInside)
        loginView?.usernameTextField.delegate = self
        loginView?.passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideLoadingServerListIndicator()
    }
}

extension LoginSceneViewController {
    
    @objc func handleLoginButtonTapped() {
        guard let username = loginView?.usernameTextField.text, let password = loginView?.passwordTextField.text else { return }
        guard username.isEmpty == false, password.isEmpty == false else { return }
        
        loginView?.usernameTextField.resignFirstResponder()
        loginView?.passwordTextField.resignFirstResponder()
        showLoadingServerListIndicator()
        Task { await interactor?.login(username: username, password: password) }
    }
}

extension LoginSceneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            loginView?.passwordTextField.becomeFirstResponder()
        } else if textField.tag == 1 {
            handleLoginButtonTapped()
        }
        return false
    }
}

extension LoginSceneViewController {
    
    func showLoadingServerListIndicator() {
        loginView?.loginButton.isEnabled = false
        loginView?.loadingIndivator.startAnimating()
        loginView?.loadingView.isHidden = false
        loginView?.loginView.isHidden = true
    }
    
    func hideLoadingServerListIndicator() {
        loginView?.loginButton.isEnabled = true
        loginView?.loadingIndivator.stopAnimating()
        loginView?.loginView.isHidden = false
        loginView?.loadingView.isHidden = true
    }
    
    func handleLoginSuccess(token: String) {
        Task { await interactor?.getServers(token: token) }
    }
    
    func showLoginErrorAlert(_ error: Error) {
        print("Login error: \(error)")
        
        let alert = UIAlertController(title: "Verification Failed", message: "Your username or password is incorrect.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func handleServerListReceived(_ servers: [Server]) {
        loginView?.usernameTextField.text = ""
        loginView?.passwordTextField.text = ""
        loginView?.usernameTextField.resignFirstResponder()
        loginView?.passwordTextField.resignFirstResponder()
        router?.navigateToServerListScene(servers: servers)
    }
    
    func showServerListError(_ error: Error) {
        let alert = UIAlertController(title: "Server Connection Failed", message: "Failed to fetch server list.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
