//
//  DetailView.swift
//  CodeScannerSwiftUI
//
//  Created by Nelson Gonzalez on 2/1/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct GenerateQRCodeView: View {
    @State private var name = ""
    @State private var emailAddress = ""
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        
        VStack(spacing: 20) {
            TextField("Name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.name)
                .font(.title)
                .padding(.horizontal)
            
            TextField("Email address", text: $emailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.emailAddress)
                .font(.title)
                .padding([.horizontal, .bottom])
            if name.isEmpty || emailAddress.isEmpty {
                Image(systemName: "xmark.circle").resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)")).interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            Spacer()
        }.padding(.top, 30)
            .navigationBarTitle("Your code", displayMode: .inline)
        
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct GenerateQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateQRCodeView()
    }
}
