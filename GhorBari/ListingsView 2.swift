import SwiftUI
import Foundation
import MapKit

struct ListingsSearchView: View {
    @EnvironmentObject var coordinator: ExploreCoordinator
    @State private var searchText: String = ""
    @State private var sort: SortOption = .priceAsc

    enum SortOption: String, CaseIterable, Identifiable {
        case priceAsc = "Price"
        case titleAsc = "Title"
        var id: String { rawValue }
    }

    private var data: [Listing] = sampleListings

    var body: some View {
        ZStack {
            // Softer background that matches the rest of the app
            Color(.systemGroupedBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    // Sticky controls
                    VStack(spacing: 12) {
                        // Search
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                            TextField("Search listings...", text: $searchText)
                                .textInputAutocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .cornerRadius(14)

                        // Sort
                        Picker("Sort", selection: $sort) {
                            Text("Price").tag(SortOption.priceAsc)
                            Text("Title").tag(SortOption.titleAsc)
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // Cards
                    LazyVStack(spacing: 18) {
                        ForEach(filteredAndSorted(data)) { listing in
                            NavigationLink(destination: ListingDetailView(listing: listing)) {
                                ListingHeroCard(listing: listing)
                                    .environmentObject(coordinator)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("Listings")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func filteredAndSorted(_ items: [Listing]) -> [Listing] {
        var results = items
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            results = results.filter {
                $0.title.localizedCaseInsensitiveContains(trimmed) ||
                $0.description.localizedCaseInsensitiveContains(trimmed)
            }
        }
        switch sort {
        case .titleAsc:
            return results.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        case .priceAsc:
            return results.sorted {
                let p0 = Double($0.price.filter("0123456789.".contains)) ?? 0
                let p1 = Double($1.price.filter("0123456789.".contains)) ?? 0
                return p0 < p1
            }
        }
    }
}

private struct ListingHeroCard: View {
    let listing: Listing
    @EnvironmentObject var coordinator: ExploreCoordinator

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .bottomLeading) {
                Group {
                    if let name = listing.photos.first, !name.isEmpty, UIImage(named: name) != nil {
                        Image(name)
                            .resizable()
                            .scaledToFill()
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(.ultraThinMaterial)
                            Image(systemName: "photo")
                                .font(.system(size: 30))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .clipped()

                // Price pill
                Text(listing.price)
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.pastelMint.opacity(0.9))
                    .foregroundColor(.primary)
                    .clipShape(Capsule())
                    .padding(12)
            }
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            VStack(alignment: .leading, spacing: 6) {
                Text(listing.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(listing.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                HStack(spacing: 12) {
                    Label("Map", systemImage: "mappin.and.ellipse")
                    Label("Details", systemImage: "info.circle")
                }
                .font(.caption)
                .foregroundColor(.secondary)

                Button {
                    coordinator.focusCoordinate = listing.coordinate
                    coordinator.selectedTabIndex = 0
                } label: {
                    Label("View on Map", systemImage: "mappin")
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .padding(.top, 6)
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 8)
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
    }
}

#Preview {
    NavigationStack {
        ListingsSearchView()
            .environmentObject(ExploreCoordinator())
    }
}
