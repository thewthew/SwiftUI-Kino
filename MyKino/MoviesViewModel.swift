//
//  MoviesViewModel.swift
//  MyKino
//
//  Created by Matthew Usdin on 2/26/23.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var isRefreshing = false

    private let apiKey = "5473ad565413781b8af8e756e42d37de"

    @MainActor
    func fetchMovies() async throws {
        let movieUrlString = "https://api.themoviedb.org/3/discover/movie"
        isRefreshing = true

        defer { isRefreshing = false }

        if let url = URL(string: movieUrlString) {

            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return
            }

            let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
            urlComponents.queryItems = queryItems

            guard let url = urlComponents.url else {
                return
            }
            let urlRequest = URLRequest(url: url)

            isRefreshing = true

            defer { isRefreshing = false }

            do {
                let (data, response) = try await URLSession.shared.data(for: urlRequest)

                guard let response = response as? HTTPURLResponse,
                      200..<299 ~= response.statusCode else {
                    throw MovieError.invalidStatusCode
                }

                let decoder = JSONDecoder()
                guard let decodedData = try? decoder.decode(MoviesInfo.self, from: data) else {
                    throw MovieError.failedToDecode
                }
                self.movies = decodedData.results

            } catch {
                throw MovieError.custom(error: error)
            }
        }
    }
}

extension MoviesViewModel {
    enum MovieError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode

        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            case .invalidStatusCode:
                return "Request falls within a invalid range"
            }
        }
    }
}
