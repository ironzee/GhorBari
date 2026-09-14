//
//  BottomTabView.swift
//  GhorBari
//
//  Created by Zulfiqur on 5/30/25.
//

import SwiftUI

struct BottomTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationView {
                ExploreMapView()
            }
            .tabItem {
                Label("Explore", systemImage: "map.fill")
            }

            NavigationView {
                PostListingView()
            }
            .tabItem {
                Label("Post", systemImage: "plus.circle")
            }

            NavigationView {
                ListingsView()
            }
            .tabItem {
                Label("Listings", systemImage: "list.bullet.rectangle")
            }

            NavigationView {
                Text("Profile")
                    .navigationTitle("Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
        .background(.ultraThinMaterial)
    }
}
