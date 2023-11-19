//
//  Order.swift
//  cupcake Corner
//
//  Created by G.K.Naidu on 21/10/23.
//

import SwiftUI

class Order : ObservableObject , Codable {
    
    enum codingKeys : CodingKey {
        case type,quantity,extraFrosting,addSprinkles,name,street,city,zip
    }
    static let types = ["Vanilla","Chocolate","Butterscotch","Strawberry","Pistachio","Maple","Tutti Frutti"]
    
    @Published var type = 0
    @Published var quantity = 1
    
    
    @Published var specialrequest = false {
        
        didSet {
            if specialrequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false 
    
    @Published var name = ""
    @Published var street = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress : Bool {
        
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let street = street.trimmingCharacters(in: .whitespacesAndNewlines)
        let city = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let zip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if name.isEmpty || street.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost : Double {
        // 400 per cake
        var cost = Double(quantity) * 400
        
        // complicated cake cost more
        
        cost += Double((type) / 2)
        
        // add ons
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    init() { }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        
        try container.encode(quantity, forKey: .quantity)
        try container.encode(type, forKey: .type)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        
        quantity = try container.decode(Int.self, forKey: .quantity)
        type = try container.decode(Int.self, forKey: .type)
        extraFrosting = try container.decode( Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        street = try container.decode(String.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
        
        
        
    }
}
