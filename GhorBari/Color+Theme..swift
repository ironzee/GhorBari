//
//  Color+Theme..swift
//  GhorBari
//
//  Created by Zulfiqur on 6/15/25.
//

import Foundation
import SwiftUI
extension Color {
    static let pastelMint = Color(hex: "#C5F2E3")
    static let pastelPink = Color(hex: "#FADAE9")
    static let pastelLavender = Color(hex: "#F1E6F9")
    static let softBackground = Color(hex: "#F3F5F9") // ✅ THIS LINE
    static let liveRed = Color(hex: "#FF4E4E")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: .alphanumerics.inverted))
        var int: UInt64 = 0
        scanner.scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}
