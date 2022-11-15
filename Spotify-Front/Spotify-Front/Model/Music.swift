//
//  Music.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/11.
//

import Foundation

struct Music {
    var name : String
    var artist : Artist
    var imageName : String
    var featuring : [Artist]?
    let length : Int
}
