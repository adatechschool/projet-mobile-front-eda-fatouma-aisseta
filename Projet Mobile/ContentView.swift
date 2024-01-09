//
//  ContentView.swift
//  Projet Mobile
//
//  Created by Aisséta Diawara on 09/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var testvalue: String = ""
    @State var answer:  String = ""
    var body: some View {
        VStack(alignment: .center) {
           //HStack{
                TextField("entrez un mot ", text: $testvalue)
                    .textFieldStyle(.roundedBorder)
                    .font(.callout)
                    .padding()
                    .frame(maxWidth: 300)
                    .cornerRadius(40)
               
                Button {
                }
            label: {
                Text("Générer")
                    .padding()
                    .font(.headline)
                    .background(Color.gray)
                    .clipShape(Capsule())
                    .foregroundColor(.black)
                    
                
            }
            //}
            
           
        }
     
    }
}

#Preview {
    ContentView()
}

