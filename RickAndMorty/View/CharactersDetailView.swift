//
//  CharactersDetailView.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 29/8/22.
//

import SwiftUI

struct CharactersDetailView: View {
    let character: Character

    var body: some View {
        Form {
            CharacterView(character: character)
                .aspectRatio(contentMode: .fill)
           
            Section("Origin") {
                SectionItemView(label: "Name", value: character.origin.name)
                if !character.origin.url.isEmpty {
                    SectionItemView(label: "URL", value: character.origin.url)
                }
            }
            
            Section("Location") {
                SectionItemView(label: "Name", value: character.location.name)
                SectionItemView(label: "URL", value: character.location.url)
            }
            
            Section("Episodes") {
                ForEach(character.episode, id: \.self) {
                    if let url = URL(string: $0) {
                        Link($0, destination: url)
                            .font(.caption2)
                    }
                }
            }
        }
    }
}

struct SectionItemView: View {
    let label, value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
            Spacer()
            if !value.isEmpty, let url = URL(string: value) {
                Link(value, destination: url)
                    .font(.caption2)
            } else {
                Text(value)
                    .font(.caption2)
            }
        }
    }
}

struct CharactersDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailView(character: Character.example)
    }
}
