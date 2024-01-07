//
//  Favorites.swift
//  Tasty
//
//  Created by Marko Ilic on 14.9.23..
//

import SwiftUI

class Favorites: ObservableObject {
    @Published var items = [MenuItem]()
    
    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }

    func add(item: MenuItem) {
        items.append(item)
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func has(item: MenuItem) -> Bool {
        items.contains(item)
    }
}
