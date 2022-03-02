import UIKit
import Firebase

class FeedVC: UICollectionViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - func
    
    private func configureUI() {
        view.backgroundColor = .white
        
        collectionView.register(FeedCVC.self, forCellWithReuseIdentifier: FeedCVC.identifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logoutDidTap(_:)))
    }
    
    // MARK: - Actions
    
    @objc private func logoutDidTap(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            let controller = LoginVC()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeedVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCVC.identifier, for: indexPath) as? FeedCVC else { return UICollectionViewCell() }
        cell.backgroundColor = .white
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension FeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 40 + 16
        height += 110
        
        return CGSize(width: width, height: height)
    }
}
