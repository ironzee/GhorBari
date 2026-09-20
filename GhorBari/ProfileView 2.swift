import SwiftUI
import Foundation

struct ProfileView: View {
    @State private var name: String = "John Appleseed"
    @State private var email: String = "john@example.com"
    @State private var notificationsEnabled: Bool = true

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Header Card
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.mint)
                            .shadow(radius: 5)

                        Text(name)
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)

                        Text(email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Button {
                        } label: {
                            Text("Edit Profile")
                                .fontWeight(.medium)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 10)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)

                    // Account Actions
                    VStack(spacing: 16) {
                        SectionHeader(title: "Account")

                        Toggle(isOn: $notificationsEnabled) {
                            Label("Push Notifications", systemImage: "bell.fill")
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .mint))
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))

                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                Label("Payment Methods", systemImage: "creditcard.fill")
                                    .fontWeight(.medium)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                        }

                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                Label("Saved Listings", systemImage: "heart.fill")
                                    .fontWeight(.medium)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .shadow(color: Color.black.opacity(0.07), radius: 6, x: 0, y: 3)
                    )
                    .padding(.horizontal)

                    // Help & About
                    VStack(spacing: 16) {
                        SectionHeader(title: "Help & About")

                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                Label("FAQ", systemImage: "questionmark.circle")
                                    .fontWeight(.medium)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                        }

                        NavigationLink {
                            EmptyView()
                        } label: {
                            HStack {
                                Label("Contact Support", systemImage: "envelope.fill")
                                    .fontWeight(.medium)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                        }

                        Button(role: .destructive) {
                        } label: {
                            HStack {
                                Label("Sign Out", systemImage: "arrow.right.square")
                                    .fontWeight(.medium)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.red.opacity(0.1))
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .shadow(color: Color.black.opacity(0.07), radius: 6, x: 0, y: 3)
                    )
                    .padding(.horizontal)

                    Spacer(minLength: 40)
                }
                .padding(.vertical, 20)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.mint)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 4)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
