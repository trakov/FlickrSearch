import UIKit

extension UISearchController {
    func hide() {
        if #available(iOS 13.0, *) {
            showsSearchResultsController = false
        } else {
            view.isHidden = true
        }
    }
    
    func show() {
        if #available(iOS 13.0, *) {
            showsSearchResultsController = true
        } else {
            view.isHidden = false
        }
    }
}
