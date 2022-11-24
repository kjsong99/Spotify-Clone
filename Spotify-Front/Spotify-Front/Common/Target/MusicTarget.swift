//
//  API.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya

enum MusicAPI{
    case getMusic(musicId : Int)
}

extension MusicAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String{
        switch self{
        case .getMusic:
            return "api/v1/music"
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
        case .getMusic(let musicId):
            return .requestParameters(parameters: ["musicId" : musicId], encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType{
         .successAndRedirectCodes
    }
    
    var headers: [String : String]?{
        return ["Content-type" : "application/json"]
    }
}
