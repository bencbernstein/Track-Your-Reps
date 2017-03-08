import Foundation
import Moya


class ProPublicaProvider {
    
    static func DefaultProvider() -> MoyaProvider<ProPublicaAPI> {
        return MoyaProvider<ProPublicaAPI>(endpointClosure: ProPublicaProvider.endpointClosure)
    }
    
    static var sharedProvider: MoyaProvider<ProPublicaAPI> {
        return ProPublicaProvider.DefaultProvider()
    }

    static func endpointClosure(_ target: ProPublicaAPI) -> Endpoint<ProPublicaAPI> {
        let sampleResponseClosure = { return EndpointSampleResponse.networkResponse(200, target.sampleData) }
        
        let method = target.method
        let parameters = target.parameters
        let endpoint = Endpoint<ProPublicaAPI>(url: url(target), sampleResponseClosure: sampleResponseClosure, method: method, parameters: parameters, parameterEncoding: target.parameterEncoding)
        return endpoint.adding(newHTTPHeaderFields: target.headers())
    }
}


//// Example Request
//
//class Backend {
//
//    let provider = ProPublicaProvider.sharedProvider
//    
//    func exampleRequest() {
//        
//        let endpoint: ProPublicaAPI = .votesForMember(id: "10")
//        
//        ProPublicaProvider.sharedProvider.request(endpoint) { (result) in
//            switch result {
//            case let .success(moyaResponse):
//                print(moyaResponse.data)
//            default:
//                print("awful")
//            }
//        }
//    }
//}
