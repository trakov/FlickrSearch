import UIKit

final class GridFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        let size = UIScreen.main.bounds.width / 2
        itemSize = CGSize(width: size, height: size)
    }
}
