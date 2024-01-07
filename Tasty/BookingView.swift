//
//  BookView.swift
//  Tasty
//
//  Created by Marko Ilic on 14.9.23..
//

import SwiftUI

struct BookingView: View {
    @StateObject var vm = ViewModel()

    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Book", selection: $vm.selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .tint(.red)
                Section {
                    Text("Joke: \(vm.joke)")
                }

                if let bookedDate = vm.bookedDate {
                    Section("What time?") {
                        Picker("What time?", selection: $vm.selectedTime.animation()) {
                            ForEach(bookedDate.value, id: \.self) { time in
                                Text("\(time)")
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.inline)
                    }
                } else {
                    Section {
                        Text("Sorry, we are all booked for \(vm.selectedDate.formatted(date: .numeric, time: .omitted)), try another day!").foregroundColor(.secondary)
                    }
                }
            }.navigationTitle("Booking").task {
                await vm.loadData()
        }
        }
    }
}

extension BookingView {
    @MainActor class ViewModel: ObservableObject {
        var bookings = Booking()
        @Published var selectedDate = Date()
        @Published var selectedTime = "What time?"
        @Published private(set) var joke = ""
        @Published private(set) var dateRange = DateInterval(start: Date(), duration: 1000000)
        
        var bookedDate: Dictionary<String, [String]>.Element? { bookings.get(date: selectedDate)
        }
        
        
        func loadData() async {
            guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data) {
                    joke = decodedResponse.value
                }
            } catch {
                print("Invalid data")
            }
            
        }
    }
}

struct Joke: Codable {
    let value: String
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
