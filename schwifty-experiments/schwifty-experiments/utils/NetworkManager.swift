//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Sean Allen on 11/12/20.
//

import UIKit

enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case invalidData
  case unableToComplete
}

struct NetworkResponse<T: Decodable>: Decodable {
  let request: [T]
}

final class NetworkManager<T: DocProtocol & Decodable> {
  private let fetchUrl: String

  init(fetchUrl: String) {
    self.fetchUrl = fetchUrl
  }

  private let cache = NSCache<NSString, UIImage>()

  public func fetch() async throws -> [T] {
    guard let url = URL(string: fetchUrl) else {
      throw NetworkError.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    print("fetched")

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.invalidResponse
    }

    let decoder = JSONDecoder()
    let decodedResponse = try decoder.decode(NetworkResponse<T>.self, from: data)
    return decodedResponse.request
  }

  func downloadImage(fromURLString urlString: String) async throws -> UIImage {
    let cacheKey = NSString(string: urlString)

    if let image = cache.object(forKey: cacheKey) {
      return image
    }

    guard let url = URL(string: urlString) else {
      throw NetworkError.invalidURL
    }

    let (data, _) = try await URLSession.shared.data(from: url)

    guard let image = UIImage(data: data) else {
      throw NetworkError.invalidData
    }

    self.cache.setObject(image, forKey: cacheKey)
    return image
  }
}
