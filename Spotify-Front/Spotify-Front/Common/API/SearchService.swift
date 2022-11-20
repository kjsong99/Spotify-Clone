//
//  SearchService.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/21.
//

import Foundation
import Moya

final class SearchService {
static let shared = SearchService()
static let decoder = JSONDecoder()
static let df = DateFormatter()
  
private init() {
    SearchService.df.dateFormat = "yyyy-MM-dd"
    SearchService.decoder.dateDecodingStrategy = .formatted(SearchService.df)
}

private let provider = MoyaProvider<SearchAPI>()

func search(keyword: String, completion: @escaping (Result<[Search], Error>) -> Void) {
    provider.request(.search(keyword: keyword)) { result in
      
          switch result {
          case let .success(response):
              
              do {
                  let results = try SearchService.decoder.decode([Search].self, from: response.data)
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
