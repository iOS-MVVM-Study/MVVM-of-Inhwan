import UIKit

class ProfileVC: UICollectionViewController {
    
    // MARK: Properties
    
    private var user: User
    
    // MARK: - initializer
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        checkIfUserIsFollowed()
    }
    
    // MARK: - API
    
    private func checkIfUserIsFollowed() {
        Task {
            do {
                guard let isFollowed = try await UserService.checkIfUserisFollowed(uid: self.user.uid) else { return }
                self.user.isFollowed = isFollowed
                await MainActor.run {
                    self.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - func
    
    private func configureCollectionView() {
        navigationItem.title = user.username
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCVC.self, forCellWithReuseIdentifier: ProfileCVC.identifier)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileHeader.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ProfileVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCVC.identifier, for: indexPath) as? ProfileCVC else { return UICollectionViewCell() }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.identifier, for: indexPath) as? ProfileHeader else { return UICollectionReusableView() }
        
        header.viewModel = ProfileHeaderViewModel(user: user)
        header.delegate = self
        
        return header
    }
}

// MARK: - UICollectionViewDelegate

extension ProfileVC {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

extension ProfileVC: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
            print("DEBUG: Show edit profile here...")
        } else if user.isFollowed {
            Task {
                do {
                    try await UserService.unfollow(uid: user.uid)
                    self.user.isFollowed = false
                    await MainActor.run {
                        self.collectionView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            Task {
                do {
                    try await UserService.follow(uid: user.uid)
                    self.user.isFollowed = true
                    await MainActor.run {
                        self.collectionView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
