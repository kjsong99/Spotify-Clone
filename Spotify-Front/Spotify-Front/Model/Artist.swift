//
//  Artist.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/15.
//

import Foundation

struct Artist {
    var id : Int
    var name : String
    var imagePath : String
    
    enum CodingKeys : String, CodingKey{
        case id, name, imagePath
    }
}

extension Artist : Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imagePath = try container.decode(String.self, forKey: .imagePath)
    }
}
