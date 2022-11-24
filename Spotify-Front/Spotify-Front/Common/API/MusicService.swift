//
//  MusicService.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya
final class MusicService {
static let shared = MusicService()
static let decoder = JSONDecoder()
static let df = DateFormatter()
  
private init() {
    MusicService.df.dateFormat = "yyyy-MM-dd"
    MusicService.decoder.dateDecodingStrategy = .formatted(MusicService.df)
}

private let provider = MoyaProvider<MusicAPI>()

func requestMusic(musicId: Int, completion: @escaping (Result<Music, Error>) -> Void) {
    provider.request(.getMusic(musicId: musicId)) { result in
      
          switch result {
          case let .success(response):
              
              do {
                  let results = try MusicService.decoder.decode(Music.self, from: response.data)
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
