//
//  FavoritesView.swift
//  Tasty
//
//  Created by Marko Ilic on 14.9.23..
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: Favorites
    var body: some View {
        if favorites.items.isEmpty {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        } else {
            VStack {
                List {
                    ForEach(favorites.items) { item in
                        ItemRow(item: item)
                    }
                }
            }
        }
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(Favorites())
    }
}
