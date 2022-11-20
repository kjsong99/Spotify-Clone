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

//class MusicObject : Object {
//    @objc dynamic var id : Int = 0
//    @objc dynamic var name : String = ""
//    @objc dynamic var imagePath : String = ""
//}
//
//extension Music : Persistable{
//    typealias ManagedObject = MusicObject
//    
//    init(managedObject: MusicObject) {
//        self.id = managedObject.id
//        self.name = managedObject.name
//        self.imagePath = managedObject.imagePath
//        self.artists = []
//        self.features = []
//    }
//    
//    func managedObject() -> MusicObject {
//        var object = MusicObject()
//        object.id = self.id
//        object.name = self.name
//        object.imagePath = self.imagePath
//        return object
//    }
//}
//

