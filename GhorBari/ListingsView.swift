////
////  ListingsView.swift
////  GhorBari
////
////  Created by Zulfiqur on 5/30/25.
////
//
//import Foundation
////
////  ListingsView.swift
////  GhorBari
////
////  Created by Zulfiqur on 5/30/25.
////
//
//import SwiftUI
//import MapKit
//
//struct ListingsView: View {
//    let listings: [Listing] = sampleListings // ✅ Use centralized listings
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVStack(spacing: 16) {
//                    ForEach(listings) { listing in
//                        NavigationLink(destination: ListingDetailView(listing: listing)) {
//                            HStack(alignment: .top, spacing: 12) {
//                                Image(listing.photos.first ?? "")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 100, height: 100)
//                                    .cornerRadius(12)
//
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text(listing.title)
//                                        .font(.headline)
//
//                                    Text(listing.price)
//                                        .foregroundColor(.green)
//
//                                    Text(listing.description)
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                        .lineLimit(2)
//                                }
//
//                                Spacer()
//                            }
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(16)
//                            .shadow(radius: 2)
//                            .padding(.horizontal)
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                }
//                .padding(.vertical)
//            }
//            .navigationTitle("All Listings")
//        }
//    }
//}
import SwiftUI
import MapKit
import Foundation

struct ListingsView: View {
    let listings: [Listing] = sampleListings

    var body: some View {
        ZStack {
            Color.softBackground.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(listings) { listing in
                        NavigationLink(destination: ListingDetailView(listing: listing)) {
                            HStack(alignment: .top, spacing: 12) {
                                Image(listing.photos.first ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(listing.title)
                                        .font(.headline)

                                    Text(listing.price)
                                        .foregroundColor(.green)

                                    Text(listing.description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }

                                Spacer()
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("All Listings")
        }
    }
}
