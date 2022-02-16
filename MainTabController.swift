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
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
    
    private func configureVCs() {
        let feedVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC())
        let searchVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
        let imageSelectorVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorVC())
        let notificationsVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationVC())
        let profileVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileVC())
        
        viewControllers = [feedVC, searchVC, imageSelectorVC, notificationsVC, profileVC]
    }
    
    private func templateNavigationVC(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        nav.navigationBar.isTranslucent = false
        return nav
    }
}
