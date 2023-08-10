private extension SearchTermsStorage {
    struct Constants {
        static let termsKey = "termsKey"
    }
}

protocol SearchTermsStoragable {
    var terms: [String] { get }
    func add(term: String)
}

final class SearchTermsStorage: SearchTermsStoragable {
    @UserDefaultsBacked(defaultValue: [], key: Constants.termsKey)
    var terms: [String]
    
    func add(term: String) {
        terms.append(term)
    }
}
