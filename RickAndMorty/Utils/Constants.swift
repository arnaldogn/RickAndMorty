//
//  Constants.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 29/8/22.
//

import Foundation

enum Constants {
    static let dateFormat:  DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()
    static let baseURL = "https://rickandmortyapi.com"
}
