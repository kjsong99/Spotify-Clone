//
//  Search.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/12.
//

import Foundation
import Realm
import RealmSwift
enum Category : String, Codable, PersistableEnum{
    case none = "None"
    case artist = "Artist"
    case music = "Music"
    case album = "Album"
    case playlist = "Playlist"
}

class Search : Object, Codable{
    @Persisted(primaryKey: true) var id : Int
    @Persisted var name : String = ""
    @Persisted var image_path : String = ""
    @Persisted var category : String = ""
    @Persisted var value_id : Int = 0
    
    public static func ==(lhs: Search, rhs: Search) -> Bool {
        if lhs.category == rhs.category && lhs.value_id == rhs.value_id{
            return true
        }else {
            return false
        }
      }
}

