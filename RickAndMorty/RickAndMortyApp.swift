//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 24/8/22.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let charactersViewModel = CharactersViewModel(service: RickAndMortyFetcher())
    
    var body: some Scene {
        WindowGroup {
            CharactersGalleryView(viewModel: charactersViewModel)
        }
    }
}
