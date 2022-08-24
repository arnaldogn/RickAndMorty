//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 25/8/22.
//

import Foundation

class CharactersViewModel: ObservableObject {
    @Published var results: [Character] = []
    private var data: CharactersList?
    private let service: CharactersProviding
    private var totalPages: Int { data?.info?.pages ?? 0 }
    private var currentPage = 1
    
    var hasMoreResults: Bool { totalPages - currentPage >= 0 }
    
    init(service: CharactersProviding) {
        self.service = service
    }
    
    @MainActor
    func fetchCharacters() {
        Task.init {
            data = try? await service.fetch(page: currentPage)
            results.append(contentsOf: data?.results ?? [])
            currentPage += 1
        }
    }
}
