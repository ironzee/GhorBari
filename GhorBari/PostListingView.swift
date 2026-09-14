////
////  PostListingView.swift
////  GhorBari
////
////  Created by Zulfiqur on 5/30/25.
////
//
//import Foundation
//import SwiftUI
//import MapKit
//import PassKit
//
//struct PostListingView: View {
//    @State private var title = ""
//    @State private var price = ""
//    @State private var description = ""
//    @State private var address = ""
//    @State private var selectedType: String = "Apartment"
//    @State private var availableFrom = Date()
//    @State private var minStay = ""
//    @State private var maxStay = ""
//    @State private var bedrooms = ""
//    @State private var bathrooms = ""
//    @State private var showPaymentSheet = false
//
//    let propertyTypes = ["Room", "Apartment", "Shared"]
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 20) {
//                    // Header
//                    HStack {
//                        Button("Cancel") {}
//                            .foregroundColor(.green)
//                        Spacer()
//                        Text("Post a Rental").bold()
//                        Spacer()
//                        Button("Save Draft") {}
//                            .foregroundColor(.green)
//                    }
//                    .padding()
//
//                    // Add Photos
//                    VStack {
//                        Image(systemName: "camera")
//                            .font(.system(size: 32))
//                            .padding(.bottom, 8)
//                        Text("Add Photos (up to 5)")
//                            .font(.headline)
//                        Text("Tap to upload")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(12)
//                    .padding(.horizontal)
//
//                    // Title and Price
//                    VStack(spacing: 12) {
//                        TextField("Listing Title", text: $title)
//                            .padding()
//                            .background(Color(.systemGray6))
//                            .cornerRadius(10)
//
//                        TextField("$ Price per month", text: $price)
//                            .keyboardType(.numberPad)
//                            .padding()
//                            .background(Color(.systemGray6))
//                            .cornerRadius(10)
//                    }
//                    .padding(.horizontal)
//
//                    // Property Type
//                    HStack(spacing: 16) {
//                        ForEach(propertyTypes, id: \.self) { type in
//                            Button(action: {
//                                selectedType = type
//                            }) {
//                                Text(type)
//                                    .padding(.vertical, 8)
//                                    .padding(.horizontal, 16)
//                                    .background(selectedType == type ? Color.green : Color.gray.opacity(0.2))
//                                    .foregroundColor(selectedType == type ? .white : .black)
//                                    .cornerRadius(8)
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//
//                    // Description
//                    TextEditor(text: $description)
//                        .frame(height: 120)
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(12)
//                        .padding(.horizontal)
//
//                    // Map & Address
//                    VStack(alignment: .leading, spacing: 8) {
//                        Map(coordinateRegion: .constant(MKCoordinateRegion(
//                            center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880),
//                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//                        )))
//                        .frame(height: 160)
//                        .cornerRadius(12)
//
//                        TextField("Enter address", text: $address)
//                            .padding()
//                            .background(Color(.systemGray6))
//                            .cornerRadius(10)
//                    }
//                    .padding(.horizontal)
//
//                    // Dates and rooms
//                    VStack(spacing: 12) {
//                        DatePicker("Available from", selection: $availableFrom, displayedComponents: .date)
//
//                        HStack {
//                            TextField("Minimum stay", text: $minStay)
//                                .keyboardType(.numberPad)
//                                .padding()
//                                .background(Color(.systemGray6))
//                                .cornerRadius(10)
//
//                            TextField("Maximum stay", text: $maxStay)
//                                .keyboardType(.numberPad)
//                                .padding()
//                                .background(Color(.systemGray6))
//                                .cornerRadius(10)
//                        }
//
//                        HStack {
//                            TextField("Bedrooms", text: $bedrooms)
//                                .keyboardType(.numberPad)
//                                .padding()
//                                .background(Color(.systemGray6))
//                                .cornerRadius(10)
//
//                            TextField("Bathrooms", text: $bathrooms)
//                                .keyboardType(.numberPad)
//                                .padding()
//                                .background(Color(.systemGray6))
//                                .cornerRadius(10)
//                        }
//                    }
//                    .padding(.horizontal)
//
//                    // Submit with Apple Pay
//                    PaymentButton(action: {
//                        // You’ll wire this to Apple Pay logic
//                        showPaymentSheet = true
//                    })
//                    .frame(height: 50)
//                    .padding()
//                }
//            }
//        }
//    }
//}
//
//// Custom Apple Pay-style button
//struct PaymentButton: View {
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            Text("Submit Listing – $5")
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.black)
//                .foregroundColor(.white)
//                .cornerRadius(12)
//        }
//    }
//}
import SwiftUI
import MapKit
import Foundation

struct PostListingView: View {
    @State private var title = ""
    @State private var price = ""
    @State private var description = ""
    @State private var address = ""
    @State private var selectedType: String = "Apartment"
    @State private var availableFrom = Date()
    @State private var minStay = ""
    @State private var maxStay = ""
    @State private var bedrooms = ""
    @State private var bathrooms = ""
    @State private var showPaymentSheet = false

    let propertyTypes = ["Room", "Apartment", "Shared"]

    var body: some View {
        ZStack {
            Color.softBackground.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Button("Cancel") {}
                            .foregroundColor(.mint)
                        Spacer()
                        Text("Post a Rental").bold()
                        Spacer()
                        Button("Save Draft") {}
                            .foregroundColor(.mint)
                    }
                    .padding()

                    VStack {
                        Image(systemName: "camera")
                            .font(.system(size: 32))
                            .padding(.bottom, 8)
                        Text("Add Photos (up to 5)")
                            .font(.headline)
                        Text("Tap to upload")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    VStack(spacing: 12) {
                        TextField("Listing Title", text: $title)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)

                        TextField("$ Price per month", text: $price)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    HStack(spacing: 16) {
                        ForEach(propertyTypes, id: \.self) { type in
                            Button(action: { selectedType = type }) {
                                Text(type)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(selectedType == type ? Color.pastelMint : Color.gray.opacity(0.2))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)

                    TextEditor(text: $description)
                        .frame(height: 120)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
                        Map(coordinateRegion: .constant(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880),
                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                        )))
                        .frame(height: 160)
                        .cornerRadius(12)

                        TextField("Enter address", text: $address)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 12) {
                        DatePicker("Available from", selection: $availableFrom, displayedComponents: .date)

                        HStack {
                            TextField("Minimum stay", text: $minStay)
                            TextField("Maximum stay", text: $maxStay)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)

                        HStack {
                            TextField("Bedrooms", text: $bedrooms)
                            TextField("Bathrooms", text: $bathrooms)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    PaymentButton(action: {
                        showPaymentSheet = true
                    })
                    .frame(height: 50)
                    .padding()
                }
            }
        }
    }
}

struct PaymentButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Submit Listing – $5")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
