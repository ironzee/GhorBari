//
//  FeaturedCardView.swift
//  GhorBari
//
//  Created by Zulfiqur on 5/30/25.


import SwiftUI

struct FeaturedCardView: View {
    let listing: Listing

    var body: some View {
        NavigationLink(destination: ListingDetailView(listing: listing)) {
            VStack(alignment: .leading, spacing: 0) {
                TabView {
                    ForEach(listing.photos, id: \.self) { photo in
                        Image(photo)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 260)
                            .clipped()
                    }
                }
                .frame(height: 260)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 6) {
                    Text(listing.price)
                        .font(.headline)
                        .foregroundColor(.green)

                    Text(listing.title)
                        .font(.subheadline)
                        .bold()

                    Text(listing.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                .padding()
                .background(.ultraThinMaterial)
            }
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(radius: 4)
            .padding(.trailing, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
