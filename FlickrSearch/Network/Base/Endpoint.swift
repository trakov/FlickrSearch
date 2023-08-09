import Foundation

private enum Hosts {
    static let host = "api.flickr.com"
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var task: HTTPTask { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        Hosts.host
    }
    
    var header: [String : String]? {
        nil
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/services" + path
        return urlComponents.url
    }
}
