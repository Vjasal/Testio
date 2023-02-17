import UIKit

protocol ServersSceneViewDelegate: AnyObject {
    func handleLogoutButtonTapped()
    func handleFilterButtonTapped()
}

class ServersSceneView {
    
    lazy var leftButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Filter"
        config.image = UIImage(systemName: "arrow.up.arrow.down")
        config.imagePadding = 9
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .small)
        config.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Logout"
        config.image = UIImage(named: "ServersSceneLogoutIcon")
        config.imagePadding = 9
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .small)
        config.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        return button
    }()
    
    lazy var leftBarButton: UIBarButtonItem = {
        return UIBarButtonItem(customView: leftButton)
    }()
    
    lazy var rightBarButton: UIBarButtonItem = {
        return UIBarButtonItem(customView: rightButton)
    }()
}

class ServersSceneTableViewCell: UITableViewCell {
    
    static let identifier = "ServerListTableViewCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: distanceLabel.leadingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            distanceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ])
    }
    
    func configure(for server: Server) {
        nameLabel.text = server.name ?? "Unknown server"
        distanceLabel.text = server.distance.map({ "\($0) km" }) ?? "? km"
    }
}

class ServersSceneTableViewHeader: UIView {
    
    lazy var nameHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "SERVER"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var distanceHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "DISTANCE"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        
        nameHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameHeaderLabel)
        addSubview(distanceHeaderLabel)
        
        NSLayoutConstraint.activate([
            nameHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameHeaderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            nameHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameHeaderLabel.trailingAnchor.constraint(equalTo: distanceHeaderLabel.leadingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            distanceHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            distanceHeaderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            distanceHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            distanceHeaderLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
}
