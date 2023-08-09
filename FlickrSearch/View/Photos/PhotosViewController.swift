import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let photosProvider: PhotosProviding = PhotosProvider()
    
    private lazy var searchViewController: SearchViewController = {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "SearchViewController"
        ) as? SearchViewController else {
            preconditionFailure("Can't find SearchViewController")
        }
        return vc
    }()
    
    private lazy var searchController: UISearchController = {
        UISearchController(searchResultsController: searchViewController)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosProvider.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PhotoCell", for: indexPath
        ) as? PhotoCell else {
            preconditionFailure()
        }
        cell.photo = photosProvider.photos[indexPath.item]
        
        return cell
    }
}

extension PhotosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension PhotosViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        // show loader
        searchViewController.results.append(text)
        self.photosProvider.search(with: text) { [weak self] success in
            // hide loader
            self?.hideSearch()
            self?.collectionView.reloadData()
        }
    }
}

private extension PhotosViewController {
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func hideSearch() {
        if #available(iOS 13.0, *) {
            searchController.showsSearchResultsController = false
        } else {
            searchController.view.isHidden = true
        }
    }
    
    func showSearch() {
        if #available(iOS 13.0, *) {
            searchController.showsSearchResultsController = true
        } else {
            searchController.view.isHidden = false
        }
    }
}
