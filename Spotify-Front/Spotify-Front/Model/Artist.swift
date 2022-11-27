//
//  Artist.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/15.
//

import Foundation
import RealmSwift
struct Artist : Codable{
    var id : Int
    var name : String
    var imagePath : String
   
}

struct ArtistValue : Codable {
    var artist : Artist
}
