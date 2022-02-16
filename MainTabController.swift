import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configureVCs()
    }
    
    // MARK: - func
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func configureVCs() {
        let feedVC = FeedVC()
        let searchVC = SearchVC()
        let imageSelectorVC = ImageSelectorVC()
        let notificationsVC = NotificationVC()
        let profileVC = ProfileVC()
        
        viewControllers = [feedVC, searchVC, imageSelectorVC, notificationsVC, profileVC]
    }
}
