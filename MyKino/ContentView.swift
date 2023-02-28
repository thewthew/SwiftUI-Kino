//
//  ContentView.swift
//  MyKino
//
//  Created by Matthew Usdin on 2/26/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = MoviesViewModel()
    @State private var hasError = false
    @State private var error: MoviesViewModel.MovieError?

    var body: some View {

        NavigationView {

            ZStack {

                if viewModel.isRefreshing {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Popular")
                                Spacer()
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 12) {
                                        ForEach(viewModel.movies, id: \.id) { movie in
                                            MovieView(movie: movie)
                                                .listRowSeparator(.hidden)
                                        }
                                    }
                                    .listStyle(.plain)
                                }
                            }
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Trending")
                                Spacer()
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 12) {
                                        ForEach(viewModel.movies, id: \.id) { movie in
                                            MovieView(movie: movie)
                                                .listRowSeparator(.hidden)
                                        }
                                    }
                                    .listStyle(.plain)
                                }
                            }
                        }
                    }
                    .navigationTitle("Movies")
                }
            }
            .task {
                await execute()
            }
            .alert(isPresented: $hasError, error: error) {
                Button {
                    Task {
                        await execute()
                    }
                } label: {
                    Text("Retry")
                }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    func execute() async {
        do {
            try await viewModel.fetchMovies()
        } catch {
            if let movieErr = error as? MoviesViewModel.MovieError {
                self.hasError = true
                self.error = movieErr
            }
        }
    }
}
