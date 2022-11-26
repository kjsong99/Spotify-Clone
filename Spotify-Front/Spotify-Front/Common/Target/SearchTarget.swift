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
    case artist(keyword : String)
    case music(keyword: String)
    case album(keyword: String)
}

extension SearchAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String{
        switch self{
        case .search:
            return "api/v1/search"
        case .artist:
            return "api/v1/search/artist"
        case .music:
            return "api/v1/search/music"
        case .album:
            return "api/v1/search/album"
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
        case .music(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.default)
        case .artist(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.default)
        case .album(let keyword):
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
