//
//  PageUser.swift
//  Projet Mobile
//
//  Created by OZDEMIR Eda on 24/01/2024.
//

import SwiftUI
import AVFoundation

struct PageUser: View {
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State private var isNextViewActive = false
    
    @State var name: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("main")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 15) {
                    Spacer()
                    
                    TextField("Email", text: $name)
                        .foregroundColor(.black) // Couleur du texte
                        .padding(10)
                        .foregroundColor(.black) // Couleur du texte
                        .foregroundColor(.black) // Couleur du texte

                        .multilineTextAlignment(.center)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        }
                        .padding(.horizontal)
                    
                    
                    HStack {
                        Group {
                            if showPassword {
                                TextField("Password",
                                          text: $password,
                                          prompt: Text("Password")
                                    .foregroundColor(.black) // Couleur du texte

                                    
                                )
                            } else {
                                SecureField("Password",
                                            text: $password,
                                            prompt: Text("Password").foregroundColor(.black))
                            }
                        }
                        .padding(10)

                        .multilineTextAlignment(.center)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                    NavigationLink(destination: HomePage(), isActive: $isNextViewActive) {
                        Button(action: {
                            print("do login or registration action")
                            
                            self.isNextViewActive = true
                        }) {
                            Text("Sign In")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                
                        }
                      
                    }
                    
               
                    
                    NavigationLink(destination: HomePage(), isActive: $isNextViewActive) {
                        Button(action: {
                            print("do login or registration action")
                            
                            self.isNextViewActive = true
                        }) {
                            Text("Connexion")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(10)
                }
            }
        }
    }
}

struct MyHomePage: View {
    var body: some View {
        Text("HomePage")
            .navigationBarTitle("HomePage", displayMode: .inline)
    }
}

struct PageUser_Previews: PreviewProvider {
    static var previews: some View {
        PageUser()
    }
}
