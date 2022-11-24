//
//  ArtistService.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/19.
//

import Foundation
import Moya
final class ArtistService {
static let shared = ArtistService()
static let decoder = JSONDecoder()
static let df = DateFormatter()
  
private init() {
    ArtistService.df.dateFormat = "yyyy-MM-dd"
    ArtistService.decoder.dateDecodingStrategy = .formatted(ArtistService.df)
}

private let provider = MoyaProvider<ArtistAPI>()

func requestArtist(artistId: Int, completion: @escaping (Result<Artist, Error>) -> Void) {
    provider.request(.getArtist(artistId: artistId)) { result in
      
          switch result {
          case let .success(response):
              
              do {
                  let results = try ArtistService.decoder.decode(Artist.self, from: response.data)
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
