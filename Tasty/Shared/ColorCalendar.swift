//
//  ColorCalendar.swift
//  Tasty
//
//  Created by Marko Ilic on 16.9.23..
//

import SwiftUI

struct ColorCalendar: UIViewRepresentable {
    @Binding var range: DateInterval
    
    func makeUIView(context: Context) -> UIDatePicker {
        UIDatePicker()
    }
    
    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.preferredDatePickerStyle = .inline
        uiView.datePickerMode = .date
        uiView.backgroundColor = .black
        uiView.tintColor = .red
        
    }
}
//
//struct ColorCalendar_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorCalendar(range: DateInterval(start: Date(), end: Date().addingTimeInterval(10000)))
//    }
//}
