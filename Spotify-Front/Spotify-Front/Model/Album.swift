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


//class AlbumObject : Object {
//    @objc dynamic var id : Int = 0
//    @objc dynamic var name : String = ""
//    @objc dynamic var imagePath : String = ""
//}
//
//extension Album : Persistable{
//    init(managedObject: AlbumObject) {
//        self.id = managedObject.id
//        self.name = managedObject.name
//        self.imagePath = managedObject.imagePath
//        self.date = Date()
//        self.musics = []
//        self.artist = Artist(id: 0, name: "", imagePath: "")
//
//    }
//
//    func managedObject() -> AlbumObject {
//        var object = AlbumObject()
//        object.id = self.id
//        object.name = self.name
//        object.imagePath = self.imagePath
//        return object
//    }
//
//    typealias ManagedObject = AlbumObject
//
//
//}
//
//
//
