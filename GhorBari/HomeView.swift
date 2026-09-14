import SwiftUI
import MapKit
import Foundation

struct HomeView: View {
    @Namespace private var topID
    @Namespace private var glassNamespace
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var selectedView = "Map View"
    @State private var selectedListing: Listing? = nil
    @State private var showDetail = false

    var body: some View {
        ScrollViewReader { proxy in
            GeometryReader { fullGeo in
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 16) {
                            Color.clear.frame(height: 1).id(topID)

                            // Picker
                            Picker("View Mode", selection: $selectedView) {
                                Text("Map View").tag("Map View")
                                Text("List View").tag("List View")
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .padding(.horizontal)

                            // Search
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                TextField("Search rentals nearby...", text: .constant(""))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .padding(.horizontal)

                            // Featured
                            Text("Featured Listings")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(sampleListings) { listing in
                                        Button {
                                            selectedListing = listing
                                        } label: {
                                            FeaturedCardView(listing: listing)
                                                .frame(width: 350, height: 400)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(24)
                                                .conditionalGlassEffectID("featured-\(listing.id)", in: glassNamespace)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }

                            // MAP or LIST
                            if selectedView == "Map View" {
                                Map(coordinateRegion: $region, annotationItems: sampleListings) { listing in
                                    MapAnnotation(coordinate: listing.coordinate) {
                                        Circle()
                                            .fill(Color.green)
                                            .frame(width: 30, height: 30)
                                            .overlay(
                                                Circle().stroke(Color.white, lineWidth: 2)
                                            )
                                            .shadow(radius: 3)
                                            .onTapGesture {
                                                selectedListing = listing
                                                showDetail = true
                                            }
                                    }
                                }
                                .frame(height: UIScreen.main.bounds.height * 0.55)
                                .cornerRadius(24)
                                .padding(.horizontal, 16)
                                .conditionalGlassEffect()
                            } else {
                                LazyVStack(spacing: 16) {
                                    ForEach(sampleListings) { listing in
                                        Button {
                                            selectedListing = listing
                                            showDetail = true
                                        } label: {
                                            HStack(spacing: 12) {
                                                Group {
                                                    if let name = listing.photos.first, !name.isEmpty, UIImage(named: name) != nil {
                                                        Image(name)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    } else {
                                                        Image(systemName: "photo")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .padding(12)
                                                            .foregroundStyle(.secondary)
                                                    }
                                                }
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
                                            .conditionalGlassEffectID("listing-\(listing.id)", in: glassNamespace)
                                            .padding(.horizontal)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.top)
                            }

                            Spacer(minLength: 60)
                        }
                    }

                    // Listing Preview Card
                    if let listing = selectedListing {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    selectedListing = nil
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                        .padding(4)
                                }
                            }

                            HStack(spacing: 12) {
                                if let name = listing.photos.first, !name.isEmpty, UIImage(named: name) != nil {
                                    Image(name)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(12)
                                        .foregroundStyle(.secondary)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                }

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

                    // Navigation
                    NavigationLink(
                        isActive: $showDetail,
                        destination: {
                            Group {
                                if let listing = selectedListing {
                                    ListingDetailView(listing: listing)
                                        .onDisappear {
                                            selectedListing = nil
                                            showDetail = false
                                        }
                                } else {
                                    EmptyView()
                                }
                            }
                        },
                        label: { EmptyView() }
                    )

                    // Scroll to Top
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    proxy.scrollTo(topID, anchor: .top)
                                }
                            }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.green)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

private extension View {
    @ViewBuilder
    func conditionalGlassEffect() -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect()
        } else {
            self
        }
    }

    @ViewBuilder
    func conditionalGlassEffectID(_ id: String, in namespace: Namespace.ID) -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffectID(id, in: namespace)
        } else {
            self
        }
    }
}

final class HomeViewModel: ObservableObject {
    @Published var selectedListing: Listing? = nil
    @Published var showDetail: Bool = false
}
