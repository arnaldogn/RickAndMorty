//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 25/8/22.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    @Published var results: [Character] = []
    private var data: CharactersList?
    private let service: RickAndMortyFetchable
    private var totalPages: Int { data?.info?.pages ?? 0 }
    private var currentPage = 1
    private var disposables = Set<AnyCancellable>()
    @Published var isFetching = false
    
    var hasMoreResults: Bool { totalPages - currentPage >= 0 }
    
    init(service: RickAndMortyFetchable) {
        self.service = service
    }
    
    func fetchCharacters() {
        isFetching = true
        service.characters(withPage: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    self.isFetching = false
                    switch value {
                    case .failure:
                        self.results = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.data = forecast
                    self.results.append(contentsOf: forecast.results)
                    self.currentPage += 1
                })
            .store(in: &disposables)
    }
}
