//
//  ContentView.swift
//  CodeScannerSwiftUI
//
//  Created by Nelson Gonzalez on 2/1/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showQRCodeView = false
    @State private var showAlert = false
    @State private var codeString = ""
    @State private var isShowingScanner = false
    @State private var QRImageShow = false
    var body: some View {
        NavigationView {
            
            VStack(spacing: 30) {
                if isShowingScanner {
                    ZStack {
                    CodeScannerView(simulatedData: "Nelson", completion: handleScan).frame(width: 400, height: 400)
                        Image(QRImageShow ? "QR" : "Focus").resizable().frame(width: 300, height: 250)
                    }
                }
                Button(action: {
                    self.isShowingScanner.toggle()
                }) {
                    Text("Scan Something").bold().foregroundColor(.white)
                }.frame(width: 200, height: 40).clipShape(RoundedRectangle(cornerRadius: 10)).background(Color.blue).cornerRadius(10).shadow(color: .gray, radius: 10)
                
                Text("Or").font(.caption).foregroundColor(.gray)
                
                NavigationLink(destination: GenerateQRCodeView(), isActive: $showQRCodeView) {
                    Button(action: {
                        self.showQRCodeView.toggle()
                    }) {
                        Text("Generate QR Code").bold().foregroundColor(.white)
                    }.frame(width: 200, height: 40).clipShape(RoundedRectangle(cornerRadius: 10)).background(Color.blue).cornerRadius(10).shadow(color: .gray, radius: 10)
                }
                
            }.navigationBarTitle("Scanner").alert(isPresented: $showAlert) {
                Alert(title: Text(""), message: Text(self.codeString), dismissButton: .default(Text("OK"), action: {
                    self.QRImageShow = false
                }))
                
            }
        }
    }
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        // more code to come
        switch result {
        case .success(let code):
          //  let details = code.components(separatedBy: "\n")
            let _ = code.components(separatedBy: "\n")
            self.codeString = code
          //  guard details.count == 2 else { return }
            self.showAlert.toggle()
            self.QRImageShow = true
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
