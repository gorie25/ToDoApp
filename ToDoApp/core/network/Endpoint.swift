//
//  Endpoint.swift
//  ToDos
//
//  Created by TienTruong on 04/02/2026.
//

import Foundation

struct Endpoint<Response> {
    var path: String
    var method: HTTPMethod
    var headerParameters: [String: String]?
    var queryParameters: [String: Any]?
    var bodyParametersEncodable: Encodable?
    
    init(
        path: String,
        method: HTTPMethod,
        headerParameters: [String: String]? = nil,
        queryParameters: [String: Any]? = nil,
        bodyParametersEncodable: Encodable? = nil
    ) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
    }
}
