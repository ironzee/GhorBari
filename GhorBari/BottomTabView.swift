//
//  BottomTabView.swift
//  GhorBari
//
//  Created by Zulfiqur on 5/30/25.
//

import SwiftUI

struct BottomTabView: View {
    @StateObject private var coordinator = ExploreCoordinator()
    
    var body: some View {
        TabView(selection: $coordinator.selectedTabIndex) {
            NavigationView {
                HomeView()
            }
            .environmentObject(coordinator)
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            NavigationView {
                PostListingView()
            }
            .environmentObject(coordinator)
            .tabItem {
                Label("Post", systemImage: "plus.circle")
            }
            .tag(1)
            
            NavigationView {
                ProfileView()
            }
            .environmentObject(coordinator)
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
            .tag(2)
        }
        .background(.ultraThinMaterial)
    }
}

