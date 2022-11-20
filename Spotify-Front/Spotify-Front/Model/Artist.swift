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
//
//class ArtistObject : Object{
//    @objc dynamic var id : Int = 0
//    @objc dynamic var name : String = ""
//    @objc dynamic var imagePath : String = ""
//}
//
//extension Artist : Persistable{
//    typealias ManagedObject = ArtistObject
//    init(managedObject: ArtistObject) {
//        self.id = managedObject.id
//        self.name = managedObject.name
//        self.imagePath = managedObject.imagePath
//    }
//    
//    func managedObject() -> ArtistObject {
//        let object = ArtistObject()
//        object.id = self.id
//        object.name = self.name
//        object.imagePath = self.imagePath
//        return object
//    }
//    
//    
//}
