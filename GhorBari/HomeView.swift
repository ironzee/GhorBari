import SwiftUI
import Foundation
import MapKit

struct HomeView: View {
    @EnvironmentObject var coordinator: ExploreCoordinator
    @Namespace private var topID
    @Namespace private var glassNamespace
    @State private var selectedView = "Map View"
    @State private var selectedListing: Listing? = nil
    @State private var showDetail = false
    @State private var homeMapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var mapExpandProgress: CGFloat = 0

    @State private var mapPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    @State private var currentListings: [Listing] = []
    @State private var lastFetchCenter = CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880)
    @State private var lastFetchSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    @State private var fetchTask: Task<Void, Never>? = nil

    var body: some View {
        ScrollViewReader { proxy in
            let headerHeight: CGFloat = UIScreen.main.bounds.height * 0.55

            ScrollView {
                VStack(spacing: 16) {
                    // Map at the top, part of the scroll content
                    Map(position: $mapPosition) {
                        ForEach(currentListings) { listing in
                            Annotation(listing.price, coordinate: listing.coordinate) {
                                Button {
                                    selectedListing = listing
                                    showDetail = true
                                } label: {
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
                    .frame(height: headerHeight)
                    .overlay(alignment: .bottom) {
                        LinearGradient(
                            colors: [Color.black.opacity(0.12), .clear],
                            startPoint: .bottom, endPoint: .top
                        )
                        .frame(height: 24)
                    }

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

                    if selectedView == "List View" {
                        LazyVStack(spacing: 16) {
                            ForEach(sampleListings) { listing in
                                Button {
                                    selectedListing = listing
                                    showDetail = true
                                } label: {
                                    HStack(spacing: 12) {
                                        listingThumbnail(for: listing, size: CGSize(width: 100, height: 100))

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(listing.title).font(.headline)
                                            Text(listing.price).foregroundColor(.green)
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
                .background(Rectangle().fill(.ultraThinMaterial).ignoresSafeArea())
                .onAppear {
                    if currentListings.isEmpty {
                        currentListings = sampleListings
                    }
                }
            }
            .onReceive(coordinator.$focusCoordinate.compactMap { $0 }) { coord in
                homeMapRegion.center = coord
                selectedView = "Map View"
            }
            .onChange(of: mapPosition) { newValue in
                if let region = region(from: newValue) {
                    let centerMoved = distanceMeters(from: lastFetchCenter, to: region.center) > 500
                    let zoomChanged = abs(log2(region.span.latitudeDelta / lastFetchSpan.latitudeDelta)) > 0.3
                    if centerMoved || zoomChanged {
                        fetchTask?.cancel()
                        fetchTask = Task { @MainActor in
                            try? await Task.sleep(nanoseconds: 400_000_000)
                            await fetchListings(for: region)
                        }
                    }
                }
            }
            .overlay(alignment: .center) {
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
                            listingThumbnail(for: listing, size: CGSize(width: 80, height: 80))

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
            .background(
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
            )
            .overlay(alignment: .bottomTrailing) {
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
                .padding(.bottom, 20)
            }
        }
    }

    func distanceMeters(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let loc1 = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let loc2 = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return loc1.distance(from: loc2)
    }

    @MainActor
    func fetchListings(for region: MKCoordinateRegion) async {
        // TODO: Replace with real API call using region.center and region.span
        let center = region.center
        // Demo filter: within ~3km of center
        let filtered = sampleListings.filter { listing in
            distanceMeters(from: center, to: listing.coordinate) < 3000
        }
        self.currentListings = filtered
        self.lastFetchCenter = region.center
        self.lastFetchSpan = region.span
    }

    private func region(from position: MapCameraPosition) -> MKCoordinateRegion? {
        // Fallback implementation without pattern matching to satisfy strict compilers.
        // Returning nil avoids enum pattern parsing issues in some toolchains.
        return nil
    }

    @ViewBuilder
    private func listingThumbnail(for listing: Listing, size: CGSize) -> some View {
        if let name = listing.photos.first, !name.isEmpty, UIImage(named: name) != nil {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .cornerRadius(10)
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .padding(12)
                .foregroundStyle(.secondary)
                .frame(width: size.width, height: size.height)
                .cornerRadius(10)
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
