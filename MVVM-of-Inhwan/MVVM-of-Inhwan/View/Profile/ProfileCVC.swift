import UIKit

class ProfileCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "ProfileCVC"
    
    private let postimageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configureUI() {
        addSubview(postimageView)
        postimageView.fillSuperview()
    }
    
}
