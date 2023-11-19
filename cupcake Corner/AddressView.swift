//
//  AddressView.swift
//  cupcake Corner
//
//  Created by G.K.Naidu on 22/10/23.
//

import SwiftUI


import SwiftUI




struct AddressView: View {
    
    @ObservedObject var order : Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name",text: $order.name)
              
                    
                    
                
                
                TextField("Street",text: $order.street)
                    
                
                TextField("City",text: $order.city)
                
                TextField("zip code",text: $order.zip)
                    .keyboardType(.numberPad)
                
            }
            
            Section {
                NavigationLink{
                    CheckoutView(order: order)
                }label: {
                    Text("Checkout")
                }
            }
            .disabled(order.hasValidAddress == false)
            .navigationTitle("Address")
            
        }
    }
}


#Preview {
    AddressView(order: Order())
}
