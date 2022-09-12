//
//  DataService.swift
//  RickAndMorty
//
//  Created by Allen Gilliam on 8/9/22.
//

import Foundation
import Combine


protocol RickAndMortyFetchable {
    func characters(withPage: Int) -> AnyPublisher<CharactersList, CustomError>
}

class RickAndMortyFetcher {
    struct API {
        static let scheme = "https"
        static let host = "rickandmortyapi.com"
        static let path = "/api/"
    }
    
    private let session: URLSession
    
    private let components: URLComponents = {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.path
        return components
    }()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension RickAndMortyFetcher: RickAndMortyFetchable {
    func characters(withPage: Int) -> AnyPublisher<CharactersList, CustomError> {
        fetch(with: makeCharactersComponents(withPage: withPage))
    }
    
    private func fetch<T: Decodable>(with components: URLComponents) -> AnyPublisher<T, CustomError> {
        guard let url = components.url else {
            let error = CustomError.wrongURL
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { _ in CustomError.noData }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

private extension RickAndMortyFetcher {
    func makeCharactersComponents(withPage page: Int) -> URLComponents {
        var temp = self.components
        temp.path += "character"
        temp.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        
        return temp
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, CustomError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(Constants.dateFormat)
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            print(String(describing: error))
            return CustomError.decoding }
        .eraseToAnyPublisher()
}
