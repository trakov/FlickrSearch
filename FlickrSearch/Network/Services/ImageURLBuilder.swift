import Foundation

protocol ImageURLBuilding {
    func build(for photo: ImageURLBuildable) -> URL?
}

protocol ImageURLBuildable {
    var id: String { get }
    var secret: String { get }
    var server: String { get }
    var farm: Int { get }
}

private extension ImageURLBuilder {
    struct Constants {
        static let urlFormat = "https://farm%d.static.flickr.com/%@/%@_%@.jpg"
    }
}

final class ImageURLBuilder: ImageURLBuilding {
    static let shared = ImageURLBuilder()
    
    func build(for photo: ImageURLBuildable) -> URL? {
        let string = String(
            format: Constants.urlFormat, photo.farm, photo.server, photo.id, photo.secret
        )
        return URL(string: string)
    }
}

extension ImageURLBuildable {
    var photoUrl: URL? {
        ImageURLBuilder.shared.build(for: self)
    }
}

extension Photo: ImageURLBuildable {}
