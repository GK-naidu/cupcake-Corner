//
//  CheckoutView.swift
//  cupcake Corner
//
//  Created by G.K.Naidu on 22/10/23.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order : Order
    @State private var ConfirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingAlert = false
    
    var body: some View {
        
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    
                        image
                        .resizable()
                        .scaledToFit()
                        
                }placeholder: {
                    ProgressView()
                }
                .frame(height:233)
                
                Text("your total cost is \(order.cost,format: .currency(code: "INR"))")
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .alert("network error",isPresented: $showingAlert) {
                    
                }message: {
                    Text("check your internet connection")
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank You", isPresented: $showingConfirmation) {
                Button("OK") { }
            }message: {
                Text(ConfirmationMessage)
            }
        }
       
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            ConfirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) is successful"
            
            showingConfirmation = true
            
        }catch {
            showingAlert.toggle()
            print(error.localizedDescription)
          
            
        }
    }
    
 
}

#Preview {
    CheckoutView(order: Order())
}
