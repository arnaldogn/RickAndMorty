//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 24/8/22.
//

import SwiftUI
import Kingfisher

struct CharactersGalleryView: View {
    @StateObject var viewModel: CharactersViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(viewModel.results) { character in
                if character == viewModel.results.last {
                    CharacterRow(character: character)
                        .onAppear {
                            if viewModel.hasMoreResults,
                               !viewModel.isFetching {
                                viewModel.fetchCharacters()
                            }
                        }
                } else {
                    CharacterRow(character: character)
                }
            }
            .overlay {
                if viewModel.isFetching {
                    ProgressView("Fetching data, please wait...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }
            }
            .task {
                viewModel.fetchCharacters()
            }
            .navigationTitle("Rick and Morty")
            .navigationDestination(for: Character.self) {
                CharactersDetailView(character: $0)
            }
        }
    }
}

struct CharacterRow: View {
    let character: Character
    var body: some View {
        NavigationLink(value: character) {
            ZStack(alignment: .topTrailing) {
                CharacterView(character: character)
                    .aspectRatio(contentMode: .fill)
                Image(systemName: "ellipsis.circle")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                    .padding(.top, 10)
            }
            .buttonStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersGalleryView(viewModel: CharactersViewModel(service: RickAndMortyFetcher()))
    }
}
