//
//  PlaylistService.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya
final class PlaylistService {
static let shared = PlaylistService()
static let decoder = JSONDecoder()
static let df = DateFormatter()
  
private init() {
    PlaylistService.df.dateFormat = "yyyy-MM-dd"
    PlaylistService.decoder.dateDecodingStrategy = .formatted(PlaylistService.df)
}

private let provider = MoyaProvider<PlaylistAPI>()

func requestPlaylist(playlistId: Int, completion: @escaping (Result<Playlist, Error>) -> Void) {
    provider.request(.getPlaylist(playlistId: playlistId)) { result in
      
          switch result {
          case let .success(response):
              
              do {
                  let results = try PlaylistService.decoder.decode(Playlist.self, from: response.data)
//                  print(try? response.mapJSON(failsOnEmptyData: false))
                  completion(.success(results))
              } catch {
                  completion(.failure(error))
              }
          case let .failure(error):
              completion(.failure(error))
          }
      }
  }
}
