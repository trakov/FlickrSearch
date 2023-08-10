import UIKit
import SDWebImage

final class PhotoCell: UICollectionViewCell {
    
    var photo: Photo? {
        didSet {
            imageView.sd_setImage(with: photo?.photoUrl) { [weak self] image, _, _, url in
                guard url == self?.photo?.photoUrl else {
                    return
                }
                self?.imageView.image = image
            }
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
}
