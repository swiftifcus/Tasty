//
//  ContentView.swift
//  Tasty
//
//  Created by Marko Ilic on 13.9.23..
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    @State private var searchText = ""
    @State private var isPresenting = false
    @State private var isPickerOpen = false
    @Environment(\.colorScheme) var colorScheme
    
    var filteredMenu: [MenuSection] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return menu
        }
//        return menu.reduce([]) { (result, section) in
//            let filteredItems = section.items.filter { item in
//                return item.name.localizedCaseInsensitiveContains(searchText)
//            }
//            var updatedResult = result
//            if !filteredItems.isEmpty {
//                var updatedSection = section
//                updatedSection.items = filteredItems
//                updatedResult.append(updatedSection)
//            }
//            return updatedResult
//        }
        
        
        let filteredSections = menu.map { section in
            let filteredItems = section.items.filter { item in
                return item.name.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            return MenuSection(id: section.id, name: section.name, items: filteredItems)
        }
        return filteredSections.filter { !$0.items.isEmpty }
    }

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(filteredMenu) { section in
                        Section(section.name) {
                            ForEach(section.items) { item in
                                Button(action: {
                                    isPresenting.toggle()
                                }) {
                                    ItemRow(item: item)
                                }.tint(colorScheme == .dark ? .white : .black)
                                .sheet(isPresented: $isPresenting) {
                                    ItemDetailSheet(item: item)
                                }
                            }
                        }
                    }
                }
                .navigationDestination(for: MenuItem.self) { item in
                    ItemDetail(item: item)
                }
                .navigationTitle("Menu")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
//                    Button {
//                        // go to filter screen
//                    } label: {
//                        Image(systemName: "line.3.horizontal.decrease.circle").tint(.black)
//                    }
                    
                    Picker(selection: $isPickerOpen) {
                        ProfileView()
                    } label: {

                                               Image(systemName: "line.3.horizontal.decrease.circle").tint(.black)

                    }


                }
                .listStyle(.grouped)
                
            }
            .searchable(text: $searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
