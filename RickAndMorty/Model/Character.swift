//
//  Character.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 24/8/22.
//

import Foundation

enum CustomError: Error {
    case decoding
    case wrongURL
    case noData
}

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

struct Character: Decodable  {
    let id: Int
    let name: String
    let status: Status
    let species, type, gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: Date?
    
    static var example =
        Character(id: 20, name: "Ants in my Eyes Johnson", status: .unknown, species: "Human", type: "Human with ants in his eyes", gender: "Male", origin: Location(name: "unknown", url: ""), location: Location(name: "Interdimensional Cable", url: "https://rickandmortyapi.com/api/location/6"), image: "https://rickandmortyapi.com/api/character/avatar/20.jpeg", episode: ["https://rickandmortyapi.com/api/episode/8"], url: "https://rickandmortyapi.com/api/character/20", created: nil)
    
    static var jsonExample =
        """
        {"id":145,"name":"Glenn","status":"Alive","species":"Human","type":"Eat shiter-Person","gender":"Male","origin":{"name":"unknown","url":""},"location":{"name":"Interdimensional Cable","url":"https://rickandmortyapi.com/api/location/6"},"image":"https://rickandmortyapi.com/api/character/avatar/145.jpeg","episode":  ["https://rickandmortyapi.com/api/episode/8"],"url":"https://rickandmortyapi.com/api/character/145","created":"2017-12-29T11:03:43.118Z"}
        """
}

extension Character: Hashable, Identifiable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Location: Decodable {
    let name: String
    let url: String
}

struct Info: Decodable {
    let count, pages: Int
    let next, prev: String?
}

struct CharactersList: Decodable {
    let info: Info?
    let results: [Character]
}
