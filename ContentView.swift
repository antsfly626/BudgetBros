//
//  ContentView.swift
//  Budget Bros
//
//  Created by neha hingorani on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State fileprivate var inputValue = 0.0
    
    @State private var percentSaved = 0.5
    @State private var percentSpentOnWants = 0.3
    @State private var percentSpentOnNeeds = 0.2
    

    
    @State private var showingLoginScreen = false
    @State private var showingBudgetScreen = false
    

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4, green: 0.6588235294, blue: 0.4392156863, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    Button("Login") {
                        // Authenticate user
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color(#colorLiteral(red: 0.4, green: 0.6588235294, blue: 0.4392156863, alpha: 1)))
                    .cornerRadius(10)
                    
                    NavigationLink(isActive: $showingLoginScreen) {
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4, green: 0.6588235294, blue: 0.4392156863, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all)
                            
                            VStack {
                                Text("Hello \(username)!")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                                Text("The 50/30/20 rule is a simple system to help you budget")
                                Image("Pie")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                Text("We'll make a 50/30/20 budget and then personalize it to your needs")
                                    .padding()
                                Text("What is your monthly income after taxes?")
                                    .padding()
                                TextField("$     ", value: $inputValue, formatter: NumberFormatter(), onCommit: {
                                    if inputValue != 0 {
                                        showingBudgetScreen = true
                                    }
                                })
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                // Add nav link here
                                NavigationLink(destination: BudgetView(inputValue: inputValue), isActive: $showingBudgetScreen) {
                                    EmptyView()
                                }
                                .hidden()
                                
                                Button("Next") {
                                    if inputValue != 0 {
                                        showingBudgetScreen = true
                                    }
                                }
                                .foregroundColor(.white)
                                .frame(width: 100, height: 30)
                                .background(Color(#colorLiteral(red: 0.4, green: 0.6588235294, blue: 0.4392156863, alpha: 1)))
                                .cornerRadius(10)
                                .padding()
                            }
                        }
                    } label: {
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "budgetbro" {
            wrongUsername = 0
            if password.lowercased() == "1234" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }

}

struct BudgetView: View {
    var inputValue: Double
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4, green: 0.6588235294, blue: 0.4392156863, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Your plan")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text("Yearly")
                    .font(.title)
                    .bold()
                    .padding()
                
                
                HStack {
                    GeometryReader { geometry in
                        VStack {
                            Image("Groceries")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Needs (50%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.5 * 12))
                            
                        }
                    }
                    GeometryReader { geometry in
                        VStack {
                            Image("ShoppingBags")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Wants (30%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.3 * 12))
                        }
                    }
                    GeometryReader { geometry in
                        VStack {
                            Image("PiggyBank")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Savings (20%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.2 * 12))
                        }
                    }
                }
                Text("Monthly")
                    .font(.title)
                    .bold()
                    .padding()
                HStack {
                    GeometryReader { geometry in
                        VStack {
                            Image("Groceries")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Needs (50%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.5))
                            
                        }
                    }
                    GeometryReader { geometry in
                        VStack {
                            Image("ShoppingBags")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Wants (30%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.3))
                        }
                    }
                    GeometryReader { geometry in
                        VStack {
                            Image("PiggyBank")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Savings (20%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.2))
                        }
                    }
                }
                Text("Weekly")
                    .font(.title)
                    .bold()
                    .padding()

                HStack {
                    GeometryReader { geometry in
                        VStack {
                            Image("Groceries")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Needs (50%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.5 * 12 / 56))
                            
                        }
                    }
                    GeometryReader { geometry in
                        VStack {
                            Image("ShoppingBags")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Wants (30%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.3 * 12 / 56))
                        }
                    }
                    GeometryReader { geometry in
                        VStack {
                            Image("PiggyBank")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                            Text("Savings (20%)")
                                .bold()
                            Text("$" + String(format: "%.2f", inputValue * 0.2 * 12 / 56))
                        }
                    }
                }
                
                
            }
            .padding(8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


