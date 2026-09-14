//
//  ListingData.swift
//  GhorBari
//
//  Created by Zulfiqur on 5/30/25.
//

import Foundation
import MapKit



let sampleListings: [Listing] = [
    Listing(
    title: "Listing #1",
    price: "$1000/month",
    description: "1BR apartment with feature #0",
    photos: ["photo1"],
    coordinate: CLLocationCoordinate2D(latitude: 33.764992, longitude: -84.371489)
),
    Listing(
    title: "Listing #2",
    price: "$1150/month",
    description: "2BR apartment with feature #1",
    photos: ["photo2"],
    coordinate: CLLocationCoordinate2D(latitude: 33.763722, longitude: -84.371437)
),
    Listing(
    title: "Listing #3",
    price: "$1300/month",
    description: "3BR apartment with feature #2",
    photos: ["photo3"],
    coordinate: CLLocationCoordinate2D(latitude: 33.749, longitude: -84.413072)
),
    Listing(
    title: "Listing #4",
    price: "$1450/month",
    description: "4BR apartment with feature #3",
    photos: ["photo4"],
    coordinate: CLLocationCoordinate2D(latitude: 33.74247, longitude: -84.391214)
),
    Listing(
    title: "Listing #5",
    price: "$1600/month",
    description: "1BR apartment with feature #4",
    photos: ["photo5"],
    coordinate: CLLocationCoordinate2D(latitude: 33.740487, longitude: -84.382303)
),
    Listing(
    title: "Listing #6",
    price: "$1750/month",
    description: "2BR apartment with feature #0",
    photos: ["photo6"],
    coordinate: CLLocationCoordinate2D(latitude: 33.737433, longitude: -84.394839)
),
    Listing(
    title: "Listing #7",
    price: "$1900/month",
    description: "3BR apartment with feature #1",
    photos: ["photo7"],
    coordinate: CLLocationCoordinate2D(latitude: 33.772618, longitude: -84.417772)
),
    Listing(
    title: "Listing #8",
    price: "$2050/month",
    description: "4BR apartment with feature #2",
    photos: ["photo8"],
    coordinate: CLLocationCoordinate2D(latitude: 33.752716, longitude: -84.365336)
),
    Listing(
    title: "Listing #9",
    price: "$2200/month",
    description: "1BR apartment with feature #3",
    photos: ["photo9"],
    coordinate: CLLocationCoordinate2D(latitude: 33.763989, longitude: -84.406872)
),
    Listing(
    title: "Listing #10",
    price: "$2350/month",
    description: "2BR apartment with feature #4",
    photos: ["photo10"],
    coordinate: CLLocationCoordinate2D(latitude: 33.778322, longitude: -84.410896)
),
    Listing(
    title: "Listing #11",
    price: "$1000/month",
    description: "3BR apartment with feature #0",
    photos: ["photo11"],
    coordinate: CLLocationCoordinate2D(latitude: 33.741773, longitude: -84.381507)
),
    Listing(
    title: "Listing #12",
    price: "$1150/month",
    description: "4BR apartment with feature #1",
    photos: ["photo12"],
    coordinate: CLLocationCoordinate2D(latitude: 33.771532, longitude: -84.366468)
),
    Listing(
    title: "Listing #13",
    price: "$1300/month",
    description: "1BR apartment with feature #2",
    photos: ["photo13"],
    coordinate: CLLocationCoordinate2D(latitude: 33.72593, longitude: -84.397417)
),
    Listing(
    title: "Listing #14",
    price: "$1450/month",
    description: "2BR apartment with feature #3",
    photos: ["photo14"],
    coordinate: CLLocationCoordinate2D(latitude: 33.754797, longitude: -84.376534)
),
    Listing(
    title: "Listing #15",
    price: "$1600/month",
    description: "3BR apartment with feature #4",
    photos: ["photo15"],
    coordinate: CLLocationCoordinate2D(latitude: 33.761038, longitude: -84.381257)
),
    Listing(
    title: "Listing #16",
    price: "$1750/month",
    description: "4BR apartment with feature #0",
    photos: ["photo1"],
    coordinate: CLLocationCoordinate2D(latitude: 33.767885, longitude: -84.365355)
),
    Listing(
    title: "Listing #17",
    price: "$1900/month",
    description: "1BR apartment with feature #1",
    photos: ["photo2"],
    coordinate: CLLocationCoordinate2D(latitude: 33.763226, longitude: -84.390054)
),
    Listing(
    title: "Listing #18",
    price: "$2050/month",
    description: "2BR apartment with feature #2",
    photos: ["photo3"],
    coordinate: CLLocationCoordinate2D(latitude: 33.764656, longitude: -84.408981)
),
    Listing(
    title: "Listing #19",
    price: "$2200/month",
    description: "3BR apartment with feature #3",
    photos: ["photo4"],
    coordinate: CLLocationCoordinate2D(latitude: 33.777755, longitude: -84.40112)
),
    Listing(
    title: "Listing #20",
    price: "$2350/month",
    description: "4BR apartment with feature #4",
    photos: ["photo5"],
    coordinate: CLLocationCoordinate2D(latitude: 33.742067, longitude: -84.368435)
),
    Listing(
    title: "Listing #21",
    price: "$1000/month",
    description: "1BR apartment with feature #0",
    photos: ["photo6"],
    coordinate: CLLocationCoordinate2D(latitude: 33.724726, longitude: -84.417435)
),
    Listing(
    title: "Listing #22",
    price: "$1150/month",
    description: "2BR apartment with feature #1",
    photos: ["photo7"],
    coordinate: CLLocationCoordinate2D(latitude: 33.741775, longitude: -84.376568)
),
    Listing(
    title: "Listing #23",
    price: "$1300/month",
    description: "3BR apartment with feature #2",
    photos: ["photo8"],
    coordinate: CLLocationCoordinate2D(latitude: 33.724481, longitude: -84.397023)
),
    Listing(
    title: "Listing #24",
    price: "$1450/month",
    description: "4BR apartment with feature #3",
    photos: ["photo9"],
    coordinate: CLLocationCoordinate2D(latitude: 33.745808, longitude: -84.389452)
),
    Listing(
    title: "Listing #25",
    price: "$1600/month",
    description: "1BR apartment with feature #4",
    photos: ["photo10"],
    coordinate: CLLocationCoordinate2D(latitude: 33.741646, longitude: -84.412594)
),
    Listing(
    title: "Listing #26",
    price: "$1750/month",
    description: "2BR apartment with feature #0",
    photos: ["photo11"],
    coordinate: CLLocationCoordinate2D(latitude: 33.766562, longitude: -84.401383)
),
    Listing(
    title: "Listing #27",
    price: "$1900/month",
    description: "3BR apartment with feature #1",
    photos: ["photo12"],
    coordinate: CLLocationCoordinate2D(latitude: 33.73313, longitude: -84.385613)
),
    Listing(
    title: "Listing #28",
    price: "$2050/month",
    description: "4BR apartment with feature #2",
    photos: ["photo13"],
    coordinate: CLLocationCoordinate2D(latitude: 33.740311, longitude: -84.384207)
),
    Listing(
    title: "Listing #29",
    price: "$2200/month",
    description: "1BR apartment with feature #3",
    photos: ["photo14"],
    coordinate: CLLocationCoordinate2D(latitude: 33.728177, longitude: -84.378442)
),
    Listing(
    title: "Listing #30",
    price: "$2350/month",
    description: "2BR apartment with feature #4",
    photos: ["photo15"],
    coordinate: CLLocationCoordinate2D(latitude: 33.729911, longitude: -84.390314)
),
    Listing(
    title: "Listing #31",
    price: "$1000/month",
    description: "3BR apartment with feature #0",
    photos: ["photo1"],
    coordinate: CLLocationCoordinate2D(latitude: 33.754262, longitude: -84.363823)
),
    Listing(
    title: "Listing #32",
    price: "$1150/month",
    description: "4BR apartment with feature #1",
    photos: ["photo2"],
    coordinate: CLLocationCoordinate2D(latitude: 33.764693, longitude: -84.379882)
),
    Listing(
    title: "Listing #33",
    price: "$1300/month",
    description: "1BR apartment with feature #2",
    photos: ["photo3"],
    coordinate: CLLocationCoordinate2D(latitude: 33.737456, longitude: -84.408133)
),
    Listing(
    title: "Listing #34",
    price: "$1450/month",
    description: "2BR apartment with feature #3",
    photos: ["photo4"],
    coordinate: CLLocationCoordinate2D(latitude: 33.760722, longitude: -84.398135)
),
    Listing(
    title: "Listing #35",
    price: "$1600/month",
    description: "3BR apartment with feature #4",
    photos: ["photo5"],
    coordinate: CLLocationCoordinate2D(latitude: 33.775684, longitude: -84.375835)
),
    Listing(
    title: "Listing #36",
    price: "$1750/month",
    description: "4BR apartment with feature #0",
    photos: ["photo6"],
    coordinate: CLLocationCoordinate2D(latitude: 33.73484, longitude: -84.382567)
),
    Listing(
    title: "Listing #37",
    price: "$1900/month",
    description: "1BR apartment with feature #1",
    photos: ["photo7"],
    coordinate: CLLocationCoordinate2D(latitude: 33.768554, longitude: -84.391683)
),
    Listing(
    title: "Listing #38",
    price: "$2050/month",
    description: "2BR apartment with feature #2",
    photos: ["photo8"],
    coordinate: CLLocationCoordinate2D(latitude: 33.749387, longitude: -84.384553)
),
    Listing(
    title: "Listing #39",
    price: "$2200/month",
    description: "3BR apartment with feature #3",
    photos: ["photo9"],
    coordinate: CLLocationCoordinate2D(latitude: 33.75967, longitude: -84.413423)
),
    Listing(
    title: "Listing #40",
    price: "$2350/month",
    description: "4BR apartment with feature #4",
    photos: ["photo10"],
    coordinate: CLLocationCoordinate2D(latitude: 33.766681, longitude: -84.365476)
)
]
