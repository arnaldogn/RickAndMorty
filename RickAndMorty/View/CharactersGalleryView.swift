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
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 1) {
                    ForEach(viewModel.results, id: \.self) { character in
                        NavigationLink(destination: CharactersDetailView(character: character)) {
                            ZStack(alignment: .topTrailing) {
                                CharacterView(character: character)
                                    .aspectRatio(contentMode: .fill)
                                Image(systemName: "ellipsis.circle")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                                    .padding(.top, 10)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    if viewModel.hasMoreResults {
                        loadingMoreView
                            .onAppear {
                                viewModel.fetchCharacters()
                            }
                    }
                }
            }
            .navigationTitle("Rick and Morty")
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
        
    var loadingMoreView: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersGalleryView(viewModel: CharactersViewModel(service: CharactersProviding()))
    }
}
