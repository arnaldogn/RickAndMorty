//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 24/8/22.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            AppContainerView()
        }
    }
}

struct AppContainerView: View {
    let charactersViewModel = CharactersViewModel(service: RickAndMortyFetcher())
    
    var body: some View {
        NavigationStack {
            CharactersGalleryView(viewModel: charactersViewModel)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case let .character(character):
                        CharactersDetailView(character: character)
                    }
                }
        }
    }
}
