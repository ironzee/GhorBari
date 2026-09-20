import SwiftUI
import MapKit
import PhotosUI
import Foundation

struct PostListingView: View {
    @State private var title = ""
    @State private var price = ""
    @State private var description = ""
    @State private var address = ""
    @State private var selectedType: String = "Apartment"
    @State private var availableFrom = Date()
    @State private var bedrooms = ""
    @State private var bathrooms = ""

    // Photos
    @State private var photoItems: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []

    // UI State
    @State private var showSuccess = false
    @FocusState private var focusedField: Field?

    enum Field: Hashable { case title, price, address, bedrooms, bathrooms }

    let propertyTypes = ["Room", "Apartment", "Shared"]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Header actions
                    HStack {
                        Text("Post a Rental")
                            .font(.title2.bold())
                        Spacer()
                        Button("Reset") { resetForm() }
                            .foregroundColor(.mint)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // Photos Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Photos")
                                .font(.headline)
                            Spacer()
                            Text("Up to 5")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        PhotosPicker(selection: $photoItems, maxSelectionCount: 5, matching: .images) {
                            HStack {
                                Image(systemName: "camera")
                                Text(images.isEmpty ? "Add Photos" : "Add More")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                        }

                        if !images.isEmpty {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 10)], spacing: 10) {
                                ForEach(Array(images.enumerated()), id: \.offset) { index, img in
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: img)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .cornerRadius(10)
                                        Button(action: { images.remove(at: index) }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.secondary)
                                                .background(.ultraThinMaterial)
                                                .clipShape(Circle())
                                        }
                                        .offset(x: 6, y: -6)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // Basic Info Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Basic Info")
                            .font(.headline)

                        TextField("Listing Title", text: $title)
                            .textContentType(.none)
                            .submitLabel(.next)
                            .focused($focusedField, equals: .title)
                            .onSubmit { focusedField = .price }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)

                        TextField("$ Price per month", text: $price)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .price)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)

                        Picker("Property Type", selection: $selectedType) {
                            ForEach(propertyTypes, id: \.self) { Text($0).tag($0) }
                        }
                        .pickerStyle(.segmented)

                        DatePicker("Available from", selection: $availableFrom, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // Description Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description")
                            .font(.headline)
                        TextEditor(text: $description)
                            .frame(height: 120)
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // Location Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Location")
                            .font(.headline)
                        TextField("Address", text: $address)
                            .textContentType(.fullStreetAddress)
                            .submitLabel(.done)
                            .focused($focusedField, equals: .address)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)

                        HStack(spacing: 12) {
                            TextField("Bedrooms", text: $bedrooms)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .bedrooms)
                            TextField("Bathrooms", text: $bathrooms)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .bathrooms)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)

                        Map(position: .constant(.region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880),
                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                        ))))
                        .frame(height: 160)
                        .cornerRadius(12)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // Submit Button
                    Button(action: submit) {
                        Text("Submit Listing")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pastelMint)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    .disabled(!isFormValid)
                    .opacity(isFormValid ? 1 : 0.6)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
            }
        }
        .onChange(of: photoItems) { _, newItems in
            Task { await loadImages(from: newItems) }
        }
        .sheet(isPresented: $showSuccess) {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.green)
                Text("Listing Submitted")
                    .font(.title2.bold())
                Text("Your listing has been submitted successfully.")
                    .foregroundColor(.secondary)
                Button("Done") { showSuccess = false }
                    .padding(.top, 8)
            }
            .padding()
            .presentationDetents([.fraction(0.35)])
        }
    }

    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !price.trimmingCharacters(in: .whitespaces).isEmpty &&
        !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func resetForm() {
        title = ""; price = ""; description = ""; address = ""
        bedrooms = ""; bathrooms = ""; availableFrom = Date()
        images.removeAll(); photoItems.removeAll()
        focusedField = nil
    }

    private func submit() {
        guard isFormValid else { return }
        // Mock submit: show success and clear form
        showSuccess = true
        resetForm()
    }

    private func loadImages(from items: [PhotosPickerItem]) async {
        images.removeAll()
        for item in items.prefix(5) {
            if let data = try? await item.loadTransferable(type: Data.self),
               let img = UIImage(data: data) {
                images.append(img)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PostListingView()
    }
}
