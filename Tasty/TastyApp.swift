//
//  TastyApp.swift
//  Tasty
//
//  Created by Marko Ilic on 13.9.23..
//

import SwiftUI

@main
struct TastyApp: App {
    @StateObject var order = Order()
    @StateObject var favorites = Favorites()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
                .environmentObject(favorites)
        }
    }
}
