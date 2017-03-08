import Foundation
import Alamofire
import Moya


enum ProPublicaAPI {
    case votesForMember(id: String)
    case membersForState(state: String)
}


extension ProPublicaAPI: TargetType {
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var task: Task { return .request }
    
    var path: String {
        switch self {
            
        case .votesForMember(let id):
            return "/members/\(id)/votes.json"
            
        case .membersForState(let state):
            return "/members/house/\(state)/current.json"
        }
    }
    
    var base: String {
        return "https://api.propublica.org/congress/v1"
    }
    
    var baseURL: URL { return URL(string: base)! }
    
    var parameters: [String: Any]? {
        switch self {
            
        default:
            return nil
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
            
        case .votesForMember:
            return stubbedResponse(.votesForMember)
            
        case .membersForState:
            return stubbedResponse(.membersForState)
        }
    }
}


extension ProPublicaAPI {
    
    var proPublicaApiKey: String { return Secrets.proPublicaApiKey.rawValue }
    
    func headers() -> [String: String] {
        let assigned: [String: String] = [
            "X-API-Key": proPublicaApiKey
        ]
        return assigned
    }
}


func url(_ route: Moya.TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
