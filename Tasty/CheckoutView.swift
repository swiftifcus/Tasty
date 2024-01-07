//
//  CheckoutView.swift
//  Tasty
//
//  Created by Marko Ilic on 13.9.23..
//

import SwiftUI
let paymentTypes = ["Cash", "Credit Card", "Tasty Points"]
let tipAmounts = [10, 15, 20, 25, 0]
let pickupTimes = ["Now", "Tonight", "Tomorrow morning"]

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    @State private var pickupTime = "Now"
    
    var totalPrice: String {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        return (total + tipValue).formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Add Tasty loyalty card", isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails {
                    TextField("Enter your Tasty ID", text: $loyaltyNumber)
                }
            }
            Section("Add a tip?") {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            }
            Section("Pickup time") {
                Picker("When:", selection: $pickupTime) {
                    ForEach(pickupTimes, id: \.self) {
                        Text("\($0)")
                    }
                }
                .labelsHidden()
                .pickerStyle(.inline)
                
            }
            Section("Total: \(totalPrice)") {
                Button("Confirm order") {
                    showingPaymentAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order confirmed", isPresented: $showingPaymentAlert) {
            // add buttons here
        } message: {
            Text("Your total was \(totalPrice) - thank you!")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
