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
            Text("** Name **: \(movie.title)")
            Text("** Email **: \(movie.overview)")
            Divider()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: .init(id: 0, title: "Topic Thunders", overview: "Amazing"))
            .previewLayout(.sizeThatFits)
    }
}
