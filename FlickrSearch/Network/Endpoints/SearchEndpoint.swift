private extension SearchEndpoint {
    struct Constants {
        static let search = "/rest"
        static let apiKey = "6af377dc54798281790fc638f6e4da5e"
    }
}

enum SearchEndpoint {
    case search(text: String, page: Int)
}

extension SearchEndpoint: Endpoint {

    var path: String {
        switch self {
        case .search:
            return Constants.search
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .search(let text, let page):
            return .requestParameters(
                bodyEncoding: .url(parameters: [
                    "method": "flickr.photos.search",
                    "api_key": Constants.apiKey,
                    "format": "json",
                    "nojsoncallback": 1,
                    "text": text,
                    "per_page": 10,
                    "page": page
                ])
            )
        }
    }
}
