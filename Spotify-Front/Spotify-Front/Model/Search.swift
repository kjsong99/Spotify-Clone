//
//  Search.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/12.
//

import Foundation

enum Category : String, Codable{
    case artist = "Artist"
    case song = "Song"
    case album = "Album"
}
struct Search : Codable{
    let name : String
    let imageName : String
    let category : Category
    let singer : String?
}
