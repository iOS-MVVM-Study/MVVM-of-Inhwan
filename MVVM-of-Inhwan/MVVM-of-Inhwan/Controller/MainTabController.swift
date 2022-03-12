import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    private var user: User? {
        didSet {
            if let user = user {
                configureVCs(withUser: user)
            }
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    // MARK: - API
    
    private func fetchUser() {
        Task {
            if let user = await UserService.fetchUser() {
                self.user = user
            }
        }
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginVC()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - func
    
    private func configureUI() {
        view.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    private func configureVCs(withUser user: User) {
        let layout = UICollectionViewFlowLayout()
        let feedVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC(collectionViewLayout: layout))
        let searchVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
        let imageSelectorVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorVC())
        let notificationsVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationVC())
        
        let profile = ProfileVC(user: user)
        let profileVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profile)
        
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

// MARK: - Extensions

extension MainTabController: AuthenticationDelegate {
    func authenticationComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
