//
//  Data.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/12.
//

import Foundation

let playlists = [Playlist(name: "It's Only Me", imageName: "Image 1"), Playlist(name: "Lead Position", imageName: "Image 2"), Playlist(name: "DRILL MUSIC IN ZION", imageName: "Image 3"), Playlist(name: "GOD DID", imageName: "Image 4"), Playlist(name: "EGOT the EP", imageName: "Image 5"), Playlist(name: "Enter The Wu-Tang (36 Chambers)", imageName: "Image 6")]

let episodes = [Episode(name: "Things You Thought You Knew - What Is Exit Velocity?", imageName: "Image 7", content: "What is exit velocity? On this episode, Neil deGrasse Tyson asks", day: "Wed", length: "1hr, 5min"), Episode(name: "211 - How to give and receive feedback - with Eric Moore", imageName: "Image 8", content: "Criticism is easily given, but rarely appreciated. At some point", day: "Fri", length: "53 min"), Episode(name: "Things You Thought You Knew - What Is Exit Velocity?", imageName: "Image 7", content: "What is exit velocity? On this episode, Neil deGrasse Tyson asks", day: "Wed", length: "1hr, 5min"), Episode(name: "Things You Thought You Knew - What Is Exit Velocity?", imageName: "Image 7", content: "What is exit velocity? On this episode, Neil deGrasse Tyson asks", day: "Wed", length: "1hr, 5min")]

let song = Music(name: "Introverted", artist: Artist(name: "", imageName: ""), imageName: "Image 9", length: 125)

var histories = [Search(name: "Elzhi", imageName: "Search 1", category: .artist, singer: nil),
                 Search(name: "Lil Baby", imageName: "Search 2", category: .artist, singer: nil),
                 Search(name: "Reasonable Doubt", imageName: "Search 3", category: .album, singer: "JAY-Z"),
                 Search(name: "Erick the Architect", imageName: "Search 4", category: .artist, singer: nil),
                 Search(name: "2000", imageName: "Search 5", category: .album, singer: "Joey Bada$$"),
                 Search(name: "Higher (feat. Nipsey Hussle & Joey Bada$$", imageName: "Search 6", category: .song, singer: "DJ Khaled")
]

let album = Album(name: "Reasonable Doubt", artist: Artist(name: "JAY-Z", imageName: "jayz"),
                  songs: [Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),
                          Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30),Music(name: "abcdefg", artist: Artist(name: "JAY-Z", imageName: "jayz"), imageName: "jayz", length: 30)],
                  imageName: "test")
