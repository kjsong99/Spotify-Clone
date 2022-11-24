//
//  API.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya

enum ArtistAPI{
    case getArtist(artistId : Int)
}

extension ArtistAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String{
        switch self{
        case .getArtist:
            return "api/v1/artist"
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
        case .getArtist(let artistId):
            return .requestParameters(parameters: ["artistId" : artistId], encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType{
         .successAndRedirectCodes
    }
    
    var headers: [String : String]?{
        return ["Content-type" : "application/json"]
    }
}
