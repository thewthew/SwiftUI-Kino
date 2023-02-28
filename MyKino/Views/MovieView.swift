//
//  MovieView.swift
//  MyKino
//
//  Created by Matthew Usdin on 2/26/23.
//

import SwiftUI

struct MovieView: View {

    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: URL(string: movie.posterFullUrlPath)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 142)
                        .clipped()
                }
                placeholder: {
                    ProgressView()
                }

            Text(movie.title)
                .lineLimit(2)
                .font(.subheadline.bold())

            Text(movie.releaseDate ?? "")
                .font(.subheadline)

            let int = movie.starNumber

            HStack {
                ForEach(0..<int, id: \.self) { _ in
                    Label("Favorite", systemImage: "star.fill")
                        .fixedSize()
                        .frame(width: 10, height: 10)
                        .labelStyle(.iconOnly)
                        .foregroundColor(.yellow)

                }
            }

        }
        .padding()
        .frame(maxWidth: 120, alignment: .leading)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieView(movie: .init(id: 0, title: "Atila",
                                   overview: "Example data",
                                   rating: 5,
                                   releaseDate: "2018",
                                   posterPath: "https://image.tmdb.org/t/p/original/tbaTFgGIaTL1Uhd0SMob6Dhi5cK.jpg"))

            MovieView(movie: .init(id: 0, title: "Puss in boots: The Last wish",
                                   overview: "Example data",
                                   rating: 4.5,
                                   releaseDate: "2018",
                                   posterPath: "https://image.tmdb.org/t/p/original/tbaTFgGIaTL1Uhd0SMob6Dhi5cK.jpg"))
        }
        .previewLayout(.sizeThatFits)

    }
}
