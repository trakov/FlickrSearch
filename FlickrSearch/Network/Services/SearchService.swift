protocol ISearchService: AnyObject {
    func search(text: String, completion: ((Result<SearchResult, RequestError>) -> Void)?)
}

final class SearchService: ISearchService, HTTPClient {
    func search(text: String, completion: ((Result<SearchResult, RequestError>) -> Void)?) {
        sendRequest(
            endpoint: SearchEndpoint.search(text: text),
            responseModel: SearchResult.self) { result in
                switch result {
                case .success(let searchResult):
                    completion?(.success(searchResult))
                case .failure(let error):
                    completion?(.failure(error))
                    print(error)
                }
            }
    }
}
