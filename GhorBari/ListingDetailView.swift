

import SwiftUI
import MapKit
import Foundation

struct ListingDetailView: View {
    let listing: Listing
    @Namespace private var glassNS

    var body: some View {
        if #available(iOS 26.0, *) {
            ScrollView {
                VStack(spacing: 24) {
                    // 📸 Image carousel with layered glass effect
                    ZStack(alignment: .bottomLeading) {
                        TabView {
                            ForEach(listing.photos, id: \.self) { photo in
                                Image(photo)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 280)
                                    .clipped()
                                    .glassEffect()
                            }
                        }
                        .frame(height: 280)
                        .tabViewStyle(PageTabViewStyle())
                        .glassEffectID("listing-photos-\(listing.id)", in: glassNS)

                        // Subtle gradient overlay
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .clear]),
                                       startPoint: .bottom, endPoint: .top)
                            .frame(height: 100)
                    }
                    .cornerRadius(20)
                    .padding(.horizontal)

                    // 🧾 Main Info Glass Card
                    GlassEffectContainer {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(listing.title)
                                .font(.title2.bold())

                            Text(listing.price)
                                .font(.title3)
                                .foregroundColor(.green)

                            HStack(spacing: 12) {
                                Label("Midtown", systemImage: "mappin.and.ellipse")
                                Label("1.2 miles away", systemImage: "location")
                            }
                            .font(.caption)
                            .foregroundColor(.gray)

                            Divider().background(.white.opacity(0.1))

                            Text("About this property")
                                .font(.headline)

                            Text("Beautiful 2-bedroom apartment in the heart of Midtown. Recently renovated with modern amenities and stunning city views.")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            // 🗺️ Map
                            Text("Location")
                                .font(.headline)

                            Map(coordinateRegion: .constant(MKCoordinateRegion(
                                center: listing.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                            )), interactionModes: [])
                                .frame(height: 150)
                                .cornerRadius(12)
                                .glassEffect()
                                .glassEffectID("map-\(listing.id)", in: glassNS)

                            Text("123 Main Street, Midtown")
                                .font(.caption)
                                .foregroundColor(.gray)

                            // 🏡 Features
                            Text("Features & Amenities")
                                .font(.headline)

                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                Label("Furnished", systemImage: "bed.double.fill")
                                Label("Wi-Fi Included", systemImage: "wifi")
                                Label("No Pets", systemImage: "nosign")
                                Label("Parking", systemImage: "parkingsign.circle")
                                Label("Gym", systemImage: "figure.strengthtraining.traditional")
                                Label("Pool", systemImage: "drop.fill")
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)

                            // 👤 Host Info
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.green)

                                VStack(alignment: .leading) {
                                    Text("John Smith")
                                        .font(.headline)
                                    Text("Usually responds within 1 hour")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }

                            // 📞 Buttons
                            HStack(spacing: 12) {
                                Button("Message") {}
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)

                                Button("Call") {}
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }

                            Button("Save Listing") {}
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.green, lineWidth: 1)
                                )
                                .glassEffect()
                                .glassEffectID("save-\(listing.id)", in: glassNS)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .glassEffect()
                        .glassEffectID("main-detail-\(listing.id)", in: glassNS)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 16)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .glassEffectID("main-detail-\(listing.id)", in: glassNS)
        } else {
            // 🔙 Fallback for iOS < 26
            ScrollView {
                Text("This page requires iOS 26 for the Liquid Glass layout.")
                    .padding()
            }
        }
    }
}
