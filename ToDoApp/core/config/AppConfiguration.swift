//
//  AppConfiguration.swift
//  ToDos
//
//  Created by TienTruong on 04/02/2026.
//

import Foundation

struct AppConfiguration {
    static let shared = AppConfiguration()
    
    var apiBaseURL: URL {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
           let url = URL(string: urlString) {
            return url
        }
        
        return URL(string: "http://localhost:8080/api/v1")!
    }
    
    private init() {}
}
