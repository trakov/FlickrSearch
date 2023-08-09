protocol PhotosProviding {
    var photos: [Photo] { get }
    func search(with text: String, completion: @escaping ((Bool) -> Void))
}

final class PhotosProvider: PhotosProviding {
    var photos: [Photo] = []
    
    private let searchService: ISearchService = SearchService()

    func search(with text: String, completion: @escaping ((Bool) -> Void)) {
        searchService.search(text: text) { [weak self] result in
            switch result {
            case .success(let searchResult):
                self?.photos = searchResult.photos.photo
                completion(true)
            case .failure(_):
                self?.photos = []
                completion(false)
            }
        }
    }
}
