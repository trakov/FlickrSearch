import Foundation

private extension ImageURLBuilder {
    struct Constants {
        static let urlFormat = "http://farm%d.static.flickr.com/%@/%@_%@.jpg"
    }
}

final class ImageURLBuilder {
    func build(for photo: Photo) -> URL? {
        let string = String(
            format: Constants.urlFormat, photo.farm, photo.server, photo.id, photo.secret
        )
        return URL(string: string)
//    http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
    }
}
