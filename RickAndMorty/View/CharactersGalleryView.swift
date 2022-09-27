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
        CharacterList(characters: viewModel.results,
                      fetchMore: viewModel.fetchMore,
                      hasMore: viewModel.hasMore)
        .navigationTitle("Rick and Morty")
    }
}

struct CharacterList: View {
    let characters: [Character]
    let fetchMore: (() -> Void)
    var hasMore: Bool
    
    var body: some View {
        List(characters) { character in
            CharacterRow(character: character)
                .if(character == characters.last) {
                    $0.onAppear {
                        if hasMore {
                            fetchMore()
                        }
                    }
                }
        }
        .overlay {
            if hasMore {
                CustomProgressView
            }
        }
        .task {
            fetchMore()
        }
    }
    
    var CustomProgressView: some View {
        ProgressView("Fetching data, please wait...")
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
    }
}

enum Route: Hashable {
    case character(Character)
}

struct CharacterRow: View {
    let character: Character
    var body: some View {
        NavigationLink(value: Route.character(character)) {
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

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
