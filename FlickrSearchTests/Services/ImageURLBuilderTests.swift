import XCTest
@testable import FlickrSearch

final class ImageURLBuilderTests: XCTestCase {

    private var urlBuilder = ImageURLBuilder()
    
    func testSuccess() {
        let urlBuildable = MockImageURLBuildable(id: "id", secret: "secret", server: "server", farm: 1)
        
        let url = urlBuilder.build(for: urlBuildable)
        
        XCTAssertEqual(url?.absoluteString, "https://farm1.static.flickr.com/server/id_secret.jpg")
    }
    
    func testFailed() {
        let urlBuildable = MockImageURLBuildable(id: "id", secret: "secret", server: "server", farm: 1)
        
        let url = urlBuilder.build(for: urlBuildable)
        
        XCTAssertNotEqual(url?.absoluteString, "https://farm2.static.flickr.com/server/id_secret.jpg")
    }

}
