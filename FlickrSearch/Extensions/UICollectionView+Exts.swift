import UIKit

extension UICollectionView {
    func scrollToTop() {
        guard numberOfItems(inSection: 0) > 0 else { return }
        scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
}
