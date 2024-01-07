//
//  ItemDetailSheet.swift
//  Tasty
//
//  Created by Marko Ilic on 23.9.23..
//

import SwiftUI

struct ItemDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var order: Order
    @EnvironmentObject var favorites: Favorites
    @State private var step = 1
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
            HStack {
                Text(item.name)
                    .font(.title)
                    .padding(.leading)
                Spacer()
            }
            HStack {
                Text(item.price.formatted(.currency(code: "USD")))
                    .font(.callout)
                    .padding(.leading)
                Spacer()
                Button {
                    if isFavorite {
                        favorites.remove(item: item)
                    } else {
                        favorites.add(item: item)
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                }.padding(.trailing)
            }
            Text(item.description)
                .padding()
            HStack {
                Stepper("I want \(step)!", value: $step, in: 1...Int.max).padding(.horizontal)
                Button("Order This!") {
                    order.add(item: item, amount: step)
                }
                .padding(.horizontal)
                .font(.callout)
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
    }
}

struct ItemDetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailSheet(item: MenuItem.example).environmentObject(Order()).environmentObject(Favorites())
    }
}

//
//    .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
//        .onEnded { value in
//            print(value.translation)
//            switch(value.translation.width, value.translation.height) {
//                case (...0, -30...30):  print("left swipe")
//                    swipe = "left swipe"
//                case (0..., -30...30):  print("right swipe")
//                    swipe = "right swipe"
//                case (-100...100, ...0):  print("up swipe")
//                case (-100...100, 0...):  print("down swipe")
//                default:  print("no clue")
//            }
//        }
//    )
