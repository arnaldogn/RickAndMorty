//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Arnaldo Gnesutta on 29/8/22.
//

import SwiftUI
import Kingfisher
import CachedAsyncImage

struct CharacterView: View {
    let character: Character
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .bottomTrailing) {
                KFImage(URL(string: character.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .center, spacing: 5) {
                    Text(character.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .colorInvert()
                    StatusView(status: character.status, species: character.species)
                }
                .padding(10)
                .background(Rectangle()
                    .opacity(0.5)
                    .cornerRadius(10))
                .padding(.trailing, 5)
                .padding(.bottom, 5)
            }
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character.example)
            .aspectRatio(contentMode: .fit)
    }
}

struct StatusView: View {
    let status: Status
    let species: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            switch status {
            case .alive:
                StatusCircle(color: .green)
            case .dead:
                StatusCircle(color: .red)
            default:
                StatusCircle(color: .gray)
            }
            
            Text(status.rawValue + " - " + species)
                .font(.caption)
                .fontWeight(.regular)
                .colorInvert()
        }
    }
}

struct StatusCircle: View {
    var color: Color
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 8, height: 8)
    }
}
