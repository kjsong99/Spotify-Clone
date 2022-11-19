//
//  Album.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/15.
//

import Foundation

struct Album {
    var id : Int
    var name : String
    var date : Date
    var imagePath : String
    var musics : [Music]
    var artist : Artist
    
    enum CodingKeys : String, CodingKey{
        case id, name, date, imagePath, musics, artist
    }
}

extension Album : Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        imagePath = try container.decode(String.self, forKey: .imagePath)
        musics = try container.decode([Music].self, forKey: .musics)
        artist = try container.decode(Artist.self, forKey: .artist)

        
    }
}
