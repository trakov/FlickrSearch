import Foundation

private extension ImageURLBuilder {
    struct Constants {
        static let urlFormat = "https://farm%d.static.flickr.com/%@/%@_%@.jpg"
    }
}

final class ImageURLBuilder {
    static let shared = ImageURLBuilder()
    
    func build(for photo: Photo) -> URL? {
        let string = String(
            format: Constants.urlFormat, photo.farm, photo.server, photo.id, photo.secret
        )
        return URL(string: string)
    }
}

extension Photo {
    var photoUrl: URL? {
        ImageURLBuilder.shared.build(for: self)
    }
}
