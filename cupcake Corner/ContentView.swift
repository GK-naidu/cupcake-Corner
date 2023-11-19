
import SwiftUI

struct ContentView : View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes   :  \(order.quantity)", value: $order.quantity,in: 1...20)
                }
                
                Section {
                    Toggle("Any special Request", isOn: $order.specialrequest.animation())
                    
                    if order.specialrequest {
                        
                            Toggle("add Sprinkles", isOn: $order.addSprinkles)
                            Toggle("Extra frosting", isOn: $order.extraFrosting)
                        
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    }label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
}







#Preview {
    ContentView()
}



