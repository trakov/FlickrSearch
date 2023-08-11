@testable import FlickrSearch

struct MockImageURLBuildable: ImageURLBuildable {
    var id: String
    var secret: String
    var server: String
    var farm: Int
}
