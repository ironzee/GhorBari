//
//  Listing.swift
//  GhorBari
//
//  Created by Zulfiqur on 5/30/25.
//

import Foundation
import MapKit

struct Listing: Identifiable, Equatable, Hashable {
    let id = UUID()
    let title: String
    let price: String
    let description: String
    let photos: [String]
    let coordinate: CLLocationCoordinate2D

    static func == (lhs: Listing, rhs: Listing) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
