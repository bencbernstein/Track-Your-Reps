///
/// ProPublicaAPI.swift
///

import Alamofire
import Foundation
import Moya


enum ProPublicaAPI {
    case bill(id: String)
    case membersForState(state: String)
    case votesForMember(id: String)
}


extension ProPublicaAPI: TargetType {
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var task: Task { return .request }
    
    var path: String {
        switch self {
            
        case .bill(let id):
            return "/115/bills/\(id)"
            
        case .membersForState(let state):
            return "/members/house/\(state)/current.json"
            
        case .votesForMember(let id):
            return "/members/\(id)/votes.json"
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
            
        case .bill:
            return stubbedResponse(.bill)
            
        case .membersForState:
            return stubbedResponse(.membersForState)
            
        case .votesForMember:
            return stubbedResponse(.votesForMember)
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
