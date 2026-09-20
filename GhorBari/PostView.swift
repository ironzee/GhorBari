import SwiftUI
import MapKit
import Foundation

struct PostView: View {
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var descriptionText: String = ""
    @State private var photoName: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var showAlert = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    Text("Create a Listing")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    GroupBox {
                        VStack(spacing: 12) {
                            TextField("Title", text: $title)
                                .textFieldStyle(.roundedBorder)
                            TextField("Price (e.g. $1,200)", text: $price)
                                .textFieldStyle(.roundedBorder)
                            TextField("Photo name in Assets (optional)", text: $photoName)
                                .textFieldStyle(.roundedBorder)
                            TextField("Latitude", text: $latitude)
                                .keyboardType(.numbersAndPunctuation)
                                .textFieldStyle(.roundedBorder)
                            TextField("Longitude", text: $longitude)
                                .keyboardType(.numbersAndPunctuation)
                                .textFieldStyle(.roundedBorder)
                            TextField("Description", text: $descriptionText, axis: .vertical)
                                .lineLimit(3, reservesSpace: true)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .conditionalGlassEffect()
                    }
                    .padding(.horizontal)

                    Button(action: submit) {
                        Text("Submit Listing")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .alert("Missing Information", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please fill in a title and price.")
        }
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func submit() {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert = true
            return
        }
        // In a real app, persist the new listing here.
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
}

#Preview {
    NavigationStack { PostView() }
}
