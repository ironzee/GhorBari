//import XCTest
//
//final class HomeViewTests: XCTestCase {
//    func testSwitchingSelectedView() throws {
//        var selectedView = "Map"
//        XCTAssertEqual(selectedView, "Map")
//        // Toggle to List
//        selectedView = "List"
//        XCTAssertEqual(selectedView, "List")
//        // Toggle back to Map
//        selectedView = "Map"
//        XCTAssertEqual(selectedView, "Map")
//    }
//
//    func testViewModelSelectionTogglesDetail() throws {
//        class HomeViewModel {
//            var selectedListing: Listing? {
//                didSet {
//                    showDetail = (selectedListing != nil)
//                }
//            }
//            var showDetail = false
//            init() {}
//        }
//        struct Listing {
//            let id: UUID
//            let title: String
//            let price: String
//            let description: String
//            let photos: [String]
//            let coordinate: Coordinate
//        }
//        struct Coordinate {
//            let latitude: Double
//            let longitude: Double
//        }
//
//        let vm = HomeViewModel()
//        XCTAssertFalse(vm.showDetail)
//        vm.selectedListing = nil
//        XCTAssertFalse(vm.showDetail)
//
//        let listing = Listing(id: UUID(), title: "Test", price: "$1000",
//                              description: "Desc", photos: [], coordinate: .init(latitude: 0, longitude: 0))
//        vm.selectedListing = listing
//        XCTAssertTrue(vm.showDetail)
//
//        vm.selectedListing = nil
//        XCTAssertFalse(vm.showDetail)
//    }
//}
