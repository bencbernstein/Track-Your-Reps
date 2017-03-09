///
/// ProPublicaProvider.swift
///

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
