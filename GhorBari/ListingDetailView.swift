import SwiftUI
import MapKit
import Foundation

struct ListingDetailView: View {
    let listing: Listing

    @State private var selectedPhotoIndex: Int = 0
    @State private var isSaved: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: Photos Carousel
                TabView(selection: $selectedPhotoIndex) {
                    ForEach(Array(listing.photos.enumerated()), id: \.offset) { index, photo in
                        ZStack(alignment: .bottomLeading) {
                            Image(photo)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 320)
                                .clipped()
                                .overlay(
                                    LinearGradient(
                                        colors: [Color.black.opacity(0.35), .clear],
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )

                            VStack(alignment: .leading, spacing: 8) {
                                Text(listing.price)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.black.opacity(0.45))
                                    .clipShape(Capsule())

                                Text(listing.title)
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .shadow(radius: 6)
                            }
                            .padding(16)
                        }
                        .tag(index)
                    }
                }
                .frame(height: 320)
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(.horizontal)

                // MARK: Quick Facts / Actions
                VStack(spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(listing.title)
                                .font(.headline)
                            Text(listing.price)
                                .font(.title3.weight(.semibold))
                                .foregroundColor(.green)
                        }
                        Spacer()
                        Button(action: { isSaved.toggle() }) {
                            Image(systemName: isSaved ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(isSaved ? .red : .primary)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }
                    }

                    HStack(spacing: 12) {
                        Label("Great location", systemImage: "mappin.and.ellipse")
                        Label("Verified host", systemImage: "checkmark.seal")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal)

                // MARK: About
                VStack(alignment: .leading, spacing: 12) {
                    Text("About this place")
                        .font(.headline)
                    Text(listing.description)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal)

                // MARK: Features
                VStack(alignment: .leading, spacing: 12) {
                    Text("Features & Amenities")
                        .font(.headline)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        Label("Furnished", systemImage: "bed.double")
                        Label("Wi‑Fi", systemImage: "wifi")
                        Label("Parking", systemImage: "parkingsign.circle")
                        Label("Gym", systemImage: "figure.strengthtraining.traditional")
                        Label("Laundry", systemImage: "washer")
                        Label("No pets", systemImage: "pawprint.slash")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal)

                // MARK: Map
                VStack(alignment: .leading, spacing: 12) {
                    Text("Location")
                        .font(.headline)
                    Map(position: .constant(.region(MKCoordinateRegion(
                        center: listing.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )))) {
                    }
                    .frame(height: 150)
                    .cornerRadius(12)

                    Text("Approximate location")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.horizontal)

                // MARK: Contact
                HStack(spacing: 12) {
                    Button(action: {}) {
                        Label("Message", systemImage: "message.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    Button(action: {}) {
                        Label("Call", systemImage: "phone.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .padding(.top, 12)
        }
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ListingDetailView(listing: sampleListings.first!)
    }
}
