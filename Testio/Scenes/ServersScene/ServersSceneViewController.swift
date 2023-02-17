import UIKit

protocol ServersSceneViewControllerProtocol: AnyObject {
    var interactor: ServersSceneInteractorProtocol? { get set }
    var router: ServersSceneRouterProtocol? { get set }
    var sceneView: ServersSceneView? { get set }
    
    func handleServersLoaded(_ servers: [Server])
    func handleLogoutDone()
}

class ServersSceneViewController: UITableViewController, ServersSceneViewControllerProtocol {
    
    enum FilterType {
        case distance
        case alphabetical
    }
    
    var interactor: ServersSceneInteractorProtocol?
    var router: ServersSceneRouterProtocol?
    var sceneView: ServersSceneView?
    
    var filterType: FilterType = .alphabetical
    var servers = [Server]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.loadServers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ServersSceneViewController: ServersSceneViewDelegate {
    
    @objc func handleLogoutButtonTapped() {
        interactor?.logout()
    }
    
    @objc func handleFilterButtonTapped() {
        let distanceAction = UIAlertAction(title: "By Distance", style: .default) { _ in
            self.handleFilterTypeSelected(.distance)
            self.tableView.reloadData()
        }
        let alphabeticalAction = UIAlertAction(title: "Alphabetical", style: .default) { _ in
            self.handleFilterTypeSelected(.alphabetical)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        switch filterType {
        case .distance:
            distanceAction.isEnabled = false
            distanceAction.setValue(UIColor.black, forKey: "titleTextColor")
        case .alphabetical:
            alphabeticalAction.isEnabled = false
            alphabeticalAction.setValue(UIColor.black, forKey: "titleTextColor")
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(distanceAction)
        alert.addAction(alphabeticalAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func handleFilterTypeSelected(_ filterType: FilterType) {
        self.filterType = filterType
        switch filterType {
        case .distance:
            servers.sort(by: { $0.distance ?? 0 < $1.distance ?? 0 })
        case .alphabetical:
            servers.sort(by: { $0.name?.lowercased() ?? "" < $1.name?.lowercased() ?? "" })
        }
    }
}

extension ServersSceneViewController {
    func handleServersLoaded(_ servers: [Server]) {
        self.servers = servers
        handleFilterTypeSelected(filterType)
        tableView.reloadData()
    }
    
    func handleLogoutDone() {
        router?.navigateToLoginScene()
    }
}

extension ServersSceneViewController {
    func setupView() {
        tableView.register(ServersSceneTableViewCell.self, forCellReuseIdentifier: ServersSceneTableViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Testio."
        navigationItem.leftBarButtonItem = sceneView?.leftBarButton
        navigationItem.rightBarButtonItem = sceneView?.rightBarButton
        
        sceneView?.leftButton.addTarget(self, action: #selector(handleFilterButtonTapped), for: .touchUpInside)
        sceneView?.rightButton.addTarget(self, action: #selector(handleLogoutButtonTapped), for: .touchUpInside)
    }
}

extension ServersSceneViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return ServersSceneTableViewHeader()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServersSceneTableViewCell.identifier) as? ServersSceneTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(for: servers[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
