//
//  ItemDetail.swift
//  Tasty
//
//  Created by Marko Ilic on 13.9.23..
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order: Order
    @EnvironmentObject var favorites: Favorites
    let item: MenuItem
    
    var isFavorite: Bool {
        favorites.has(item: item)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .offset(x: -5, y: -5)
            }
            Text(item.description)
                .padding()
            Button("Order This!") {
                order.add(item: item)
            }
            .font(.callout)
            .buttonStyle(.borderedProminent)
            Spacer()
        }.navigationTitle(item.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    if isFavorite {
                        favorites.remove(item: item)
                  
                    } else {
                        favorites.add(item: item)
                      
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart" )
                }

            }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemDetail(item: MenuItem.example).environmentObject(Order())
                .environmentObject(Favorites())
        }
    }
}
