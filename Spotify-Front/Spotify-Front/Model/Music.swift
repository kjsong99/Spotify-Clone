//
//  Music.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/11.
//

import Foundation
import RealmSwift

struct Music : Codable{
    var id : Int
    var name : String
    var imagePath : String
    var artists : [ArtistValue]
    var features : [ArtistValue]?

}
