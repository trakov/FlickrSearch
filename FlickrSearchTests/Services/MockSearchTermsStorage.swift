@testable import FlickrSearch

final class MockSearchTermsStorage: SearchTermsStoragable {
    var terms: [String] = []
    
    func add(term: String) {
        terms.append(term)
    }
    
    func clear() {
        terms = []
    }
}
