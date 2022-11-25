//
//  AlbumService.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya
final class AlbumService {
static let shared = AlbumService()
static let decoder = JSONDecoder()
static let df = DateFormatter()
  
private init() {
    AlbumService.df.dateFormat = "yyyy-MM-dd"
    AlbumService.decoder.dateDecodingStrategy = .formatted(AlbumService.df)
}

private let provider = MoyaProvider<AlbumAPI>()

func requestAlbum(albumId: Int, completion: @escaping (Result<Album, Error>) -> Void) {
    provider.request(.getAlbum(albumId: albumId)) { result in
      
          switch result {
          case let .success(response):
              
              do {
                  let results = try AlbumService.decoder.decode(Album.self, from: response.data)
                  
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
