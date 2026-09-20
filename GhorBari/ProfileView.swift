//import SwiftUI
//import Foundation
//
//struct ProfileView: View {
//    @State private var name: String = "Alex Doe"
//    @State private var email: String = "alex@example.com"
//    @State private var notificationsEnabled: Bool = true
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(.ultraThinMaterial)
//                .ignoresSafeArea()
//
//            ScrollView {
//                VStack(spacing: 20) {
//                    VStack(spacing: 12) {
//                        ZStack {
//                            Circle()
//                                .fill(.ultraThinMaterial)
//                                .frame(width: 100, height: 100)
//                                .conditionalGlassEffect()
//                            Image(systemName: "person.fill")
//                                .font(.system(size: 44))
//                                .foregroundStyle(.green)
//                        }
//                        Text("Profile")
//                            .font(.largeTitle.bold())
//                            .foregroundColor(.green)
//                    }
//                    .padding(.top, 32)
//
//                    VStack(spacing: 16) {
//                        TextField("Name", text: $name)
//                            .textFieldStyle(.roundedBorder)
//                        TextField("Email", text: $email)
//                            .textFieldStyle(.roundedBorder)
//                        Toggle("Notifications", isOn: $notificationsEnabled)
//                            .tint(.green)
//                    }
//                    .padding()
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(16)
//                    .padding(.horizontal)
//                    .conditionalGlassEffect()
//
//                    Button(role: .destructive) {
//                        // Sign out action
//                    } label: {
//                        Text("Sign Out")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.red.opacity(0.9))
//                            .foregroundColor(.white)
//                            .cornerRadius(12)
//                    }
//                    .padding(.horizontal)
//
//                    Spacer(minLength: 40)
//                }
//            }
//        }
//        .navigationTitle("Profile")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//private extension View {
//    @ViewBuilder
//    func conditionalGlassEffect() -> some View {
//        if #available(iOS 26.0, *) {
//            self.glassEffect()
//        } else {
//            self
//        }
//    }
//}
//
//#Preview { NavigationStack { ProfileView() } }
