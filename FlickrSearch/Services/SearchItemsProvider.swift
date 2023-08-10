protocol PhotosProviding {
    var photos: [Photo] { get }
    func search(with text: String, completion: @escaping ((Bool) -> Void))
    func loadMore(completion: @escaping (([Photo]) -> Void))
}

final class PhotosProvider: PhotosProviding {
    var photos: [Photo] = []
    
    private var currentPage = 0
    private var currentText = ""
    private var isLoading = false
    private let searchService: ISearchService = SearchService()

    func search(with text: String, completion: @escaping ((Bool) -> Void)) {
        currentPage = 0
        currentText = text
        searchCurrent { [weak self] text, photos in
            self?.photos = photos
            completion(!photos.isEmpty)
        }
    }
    
    func loadMore(completion: @escaping (([Photo]) -> Void)) {
        guard !isLoading else {
            return
        }
        currentPage += 1
        searchCurrent { [weak self] text, photos in
            guard text == self?.currentText else {
                return completion([])
            }
            self?.photos.append(contentsOf: photos)
            completion(photos)
        }
    }
}

private extension PhotosProvider {
    func searchCurrent(completion: @escaping ((String, [Photo]) -> Void)) {
        isLoading = true
        let text = currentText
        searchService.search(text: text, page: currentPage) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let searchResult):
                completion(text, searchResult.photos.photo)
            case .failure(_):
                completion(text, [])
            }
        }
    }
}
