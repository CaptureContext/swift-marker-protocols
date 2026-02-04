// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "swift-marker-protocols",
	products: [
		.library(
			name: "AVFoundationMarkerProtocols",
			targets: ["AVFoundationMarkerProtocols"]
		),
		.library(
			name: "CocoaMarkerProtocols",
			targets: ["CocoaMarkerProtocols"]
		),
		.library(
			name: "FoundationMarkerProtocols",
			targets: ["FoundationMarkerProtocols"]
		),
		.library(
			name: "MarkerProtocols",
			targets: ["MarkerProtocols"]
		),
		.library(
			name: "QuartzCoreMarkerProtocols",
			targets: ["QuartzCoreMarkerProtocols"]
		),
		.library(
			name: "SwiftMarkerProtocols",
			targets: ["SwiftMarkerProtocols"]
		),
	],
	targets: [
		.target(
			name: "MarkerProtocols",
			dependencies: [
				.target(name: "AVFoundationMarkerProtocols"),
				.target(name: "CocoaMarkerProtocols"),
				.target(name: "QuartzCoreMarkerProtocols"),
				.target(name: "FoundationMarkerProtocols"),
				.target(name: "SwiftMarkerProtocols"),
			]
		),
		.target(
			name: "CocoaMarkerProtocols",
			dependencies: [
				.target(name: "SwiftMarkerProtocols"),
				.target(name: "QuartzCoreMarkerProtocols"),
			]
		),
		.target(
			name: "QuartzCoreMarkerProtocols",
			dependencies: [
				.target(name: "FoundationMarkerProtocols"),
			]
		),
		.target(
			name: "AVFoundationMarkerProtocols",
			dependencies: [
				.target(name: "FoundationMarkerProtocols"),
			]
		),
		.target(
			name: "FoundationMarkerProtocols",
			dependencies: [
				.target(name: "SwiftMarkerProtocols"),
			]
		),
		.target(name: "SwiftMarkerProtocols"),
		.testTarget(
			name: "SwiftMarkerProtocolsTests",
			dependencies: [
				.target(name: "SwiftMarkerProtocols")
			]
		),
	]
)
