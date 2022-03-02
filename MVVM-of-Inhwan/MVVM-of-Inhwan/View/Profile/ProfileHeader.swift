import UIKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier: String = "ProfileHeader"
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
