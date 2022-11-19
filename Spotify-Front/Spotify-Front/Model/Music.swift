//
//  Music.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/11.
//

import Foundation

struct Music{
    var id : Int
    var name : String
    enum CodingKeys : String, CodingKey{
        case id, name
    }
}

extension Music : Decodable{
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
