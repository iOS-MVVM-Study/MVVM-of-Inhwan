import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureVCs()
        checkIfUserIsLoggedIn()
//        logout()
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginVC()
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
    
    private func configureVCs() {
        let layout = UICollectionViewFlowLayout()
        let feedVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC(collectionViewLayout: layout))
        let searchVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
        let imageSelectorVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorVC())
        let notificationsVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationVC())
        
        let profileLayout = UICollectionViewFlowLayout()
        let profileVC = templateNavigationVC(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileVC(collectionViewLayout: profileLayout))
        
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
