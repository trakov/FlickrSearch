import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let photosProvider: PhotosProviding = PhotosProvider()
    private let searchTermsStorage: SearchTermsStoragable = SearchTermsStorage()
    
    private lazy var searchViewController: SearchViewController = {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: "SearchViewController"
        ) as? SearchViewController else {
            preconditionFailure("Can't find SearchViewController")
        }
        vc.searchTermsStorage = searchTermsStorage
        vc.didSelectTerm = { [weak self] term in
            self?.search(text: term)
        }
        return vc
    }()
    
    private lazy var searchController: UISearchController = {
        UISearchController(searchResultsController: searchViewController)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        collectionView.collectionViewLayout = GridFlowLayout()
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

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == collectionView.numberOfItems(inSection: 0) - 2 {
            photosProvider.loadMore { [weak self] photos in
                let n = collectionView.numberOfItems(inSection: 0)
                let indexPaths = photos.enumerated().map {
                    IndexPath(item: n + $0.offset, section: 0)
                }
                self?.collectionView.insertItems(at: indexPaths)
            }
        }
    }
}

extension PhotosViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}

extension PhotosViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchViewController.reloadData()
        searchController.show()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(text: searchBar.text)
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
    
    func search(text: String?) {
        guard let text = text, !text.isEmpty else { return }
        // show loader
        collectionView.scrollToTop()
        searchTermsStorage.add(term: text)
        searchController.hide()
        self.photosProvider.search(with: text) { [weak self] success in
            // hide loader
            self?.collectionView.reloadData()
        }
    }
}
