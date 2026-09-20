import SwiftUI
import MapKit
import Foundation

final class ExploreCoordinator: ObservableObject {
    @Published var selectedTabIndex: Int = 0 // 0: Home, 1: Explore, 2: Post, 3: Listings, 4: Profile
    @Published var focusCoordinate: CLLocationCoordinate2D? = nil

    func showOnMap(_ coordinate: CLLocationCoordinate2D) {
        focusCoordinate = coordinate
        selectedTabIndex = 1 // switch to Explore tab
    }
}
