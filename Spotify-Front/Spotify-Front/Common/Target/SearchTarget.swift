//
//  SearchTarget.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/20.
//

import Foundation
import Moya

enum SearchAPI{
    case search(keyword : String)
}

extension SearchAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String{
        switch self{
        case .search:
            return "api/v1/search"
        }
    }
    
    var method: Moya.Method{
        return .get
    }
    
    var sampleData: Data{
        return Data()
    }
    
    var task: Task{
        switch self {
        case .search(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType{
         .successAndRedirectCodes
    }
    
    var headers: [String : String]?{
        return ["Content-type" : "application/json"]
    }
}
