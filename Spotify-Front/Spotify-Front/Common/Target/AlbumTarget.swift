//
//  API.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya

enum AlbumAPI{
    case getAlbum(albumId : Int)
}

extension AlbumAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String{
        switch self{
        case .getAlbum:
            return "api/v1/album"
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
        case .getAlbum(let albumId):
            return .requestParameters(parameters: ["albumId" : albumId], encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType{
         .successAndRedirectCodes
    }
    
    var headers: [String : String]?{
        return ["Content-type" : "application/json"]
    }
}
