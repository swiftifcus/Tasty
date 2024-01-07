//
//  ProfileView.swift
//  Tasty
//
//  Created by Marko Ilic on 24.9.23..
//

import SwiftUI
import CoreImage.CIFilterBuiltins

let barcode = "Hacking with Swift is the best iOS coding tutorial I've ever read!"

struct ProfileView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    var image: UIImage? {
        generateQRCode(from: barcode)
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    Section("User information") {
                        NavigationLink("Hello") {
                            
                        }
                        NavigationLink("World") {
                            
                        }
                    }
                    if let image = image {
                        VStack {
                            Image(uiImage: image)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                            Text(barcode)
                                .font(.caption2)
                                
//                                .frame(width: 200, height: 200)
                        }
                    }
                    

                }
                .navigationTitle("Profile")
            }
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
