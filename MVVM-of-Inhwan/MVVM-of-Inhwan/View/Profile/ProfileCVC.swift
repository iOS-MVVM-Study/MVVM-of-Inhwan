import UIKit

class ProfileCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "ProfileCVC"
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
