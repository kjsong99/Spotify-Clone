//
//  API.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya

enum PlaylistAPI{
    case getPlaylist(playlistId : Int)
}

extension PlaylistAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String{
        switch self{
        case .getPlaylist:
            return "api/v1/playlist"
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
        case .getPlaylist(let playlistId):
            return .requestParameters(parameters: ["playlistId" : playlistId], encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType{
         .successAndRedirectCodes
    }
    
    var headers: [String : String]?{
        return ["Content-type" : "application/json"]
    }
}
