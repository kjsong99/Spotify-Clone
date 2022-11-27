//
//  Album.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/15.
//

import Foundation
import RealmSwift
struct Album : Codable{
    var id : Int
    var name : String
    var date : Date
    var imagePath : String
    var musics : [Music]
    var artist : Artist
    
}

