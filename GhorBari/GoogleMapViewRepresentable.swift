//
//  GoogleMapViewRepresentable.swift
//  GhorBari
//
//  Created by Zulfiqur on 6/23/25.
//

import Foundation
import SwiftUI
import GoogleMaps

struct GoogleMapViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(
            withLatitude: 33.7490,
            longitude: -84.3880,
            zoom: 12.0
        )
        let mapView = GMSMapView(frame: .zero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.zoomGestures = true
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // optional: dynamically update map here
    }
}

