//
//  GhorBariApp.swift
//  GhorBari
//
//  Created by Zulfiqur on 5/30/25.
//

import SwiftUI
import GoogleMaps

@main
struct GhorBariApp: App {
    
    // Attach AppDelegate for Google Maps SDK setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            BottomTabView()
        }
    }
}

// MARK: - AppDelegate for Google Maps API Key
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let key = Bundle.main.object(forInfoDictionaryKey: "GMSAPIKey") as? String
        if let key, !key.isEmpty {
            GMSServices.provideAPIKey(key)
        } else {
            #if DEBUG
            print("[AppDelegate] Warning: Missing Google Maps API key. Add 'GMSAPIKey' to Info.plist.")
            #endif
        }
        return true
    }
}
