import SwiftUI
import MapKit
import Foundation

struct ExploreMapView: View {
    @EnvironmentObject var coordinator: ExploreCoordinator
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var selectedListing: Listing? = nil
    @State private var showDetail = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: .constant(.region(region))) {
                ForEach(sampleListings) { listing in
                    Annotation(listing.price, coordinate: listing.coordinate) {
                        Button(action: {
                            selectedListing = listing
                            showDetail = true
                        }) {
                            Text(listing.price)
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .foregroundColor(.primary)
                                .clipShape(Capsule())
                                .shadow(radius: 3)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .onReceive(coordinator.$focusCoordinate.compactMap { $0 }) { coord in
                region.center = coord
            }

            if let listing = selectedListing {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        Image(listing.photos.first ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(listing.title)
                                .font(.headline)
                                .lineLimit(1)

                            Text(listing.price)
                                .font(.subheadline)
                                .foregroundColor(.green)

                            Text(listing.description)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        Spacer()
                    }

                    Button(action: {
                        showDetail = true
                    }) {
                        Text("View Details")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding()
                .shadow(radius: 10)
                .transition(.move(edge: .bottom))
            }
        }
        .navigationDestination(isPresented: $showDetail) {
            if let listing = selectedListing {
                ListingDetailView(listing: listing)
            }
        }
    }
}
