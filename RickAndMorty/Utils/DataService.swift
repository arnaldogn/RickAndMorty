//
//  DataService.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 24/8/22.
//

import Foundation

protocol EndpointProtocol {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL { get throws }
    var baseURL: String { get }
}

extension EndpointProtocol {
    var url: URL  {
        get throws {
            var components = URLComponents(string: baseURL)
            components?.path = path
            components?.queryItems = queryItems
            guard let url = components?.url
            else { throw CustomError.wrongURL }
            return url
        }
    }
}

protocol NetworkingProtocol {
    func fetch<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T
}

extension NetworkingProtocol {
    func fetch<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T {
        let url = try endpoint.url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(Constants.dateFormat)
            return try decoder.decode(T.self, from: data)
        }
        catch {
            throw CustomError.noData
        }
    }
}

enum RickAndMortyEndpoint: EndpointProtocol {
    var baseURL: String { Constants.baseURL }
    case character(page: Int)
}

extension RickAndMortyEndpoint {
    var path: String {
        switch self {
        case .character:
            return "/api/character"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .character(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        }
    }
}

protocol CharactersProvidingProtocol {
    var network: NetworkingProtocol { get }
    func fetch(page: Int) async throws -> CharactersList
}

extension CharactersProvidingProtocol {
    var network: NetworkingProtocol { Network() }
    func fetch(page: Int) async throws -> CharactersList {
        try await network.fetch(RickAndMortyEndpoint.character(page: page))
    }
}

class Network: NetworkingProtocol {}
class CharactersProviding: CharactersProvidingProtocol {}
