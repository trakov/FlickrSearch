import XCTest
@testable import FlickrSearch

final class SearchTermsStorageTests: XCTestCase {

    private var termsStorage = MockSearchTermsStorage()
    
    override func setUp() {
        termsStorage.clear()
    }
    
    func testAddSuccess() {
        termsStorage.add(term: "test")
        
        XCTAssert(termsStorage.terms.contains("test"))
    }
    
    func testAddFailed() {
        termsStorage.add(term: "test2")
        
        XCTAssertFalse(termsStorage.terms.contains("test"))
    }
}
