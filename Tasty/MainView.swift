//
//  MainView.swift
//  Tasty
//
//  Created by Marko Ilic on 13.9.23..
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var favorites: Favorites
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            BookingView()
                .tabItem {
                    Label("Booking", systemImage: "book")
                }
            if !favorites.isEmpty {
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
            }
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
            .environmentObject(Favorites())
    }
}
