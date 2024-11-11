// swift-tools-version:6.0

//
//  Renderer.hpp
//  DisplayLinkModifier
//
//  Created by Kristian Trenskow on 10/11/2024.
//

import PackageDescription

let package = Package(
	name: "DisplayLinkModifier",
	platforms: [.iOS(.v15)],
	products: [
		.library(
			name: "DisplayLinkModifier", 
			targets: ["DisplayLinkModifier"]),
	],
	targets: [
		.target(
			name: "DisplayLinkModifier")
	],
	cxxLanguageStandard: .cxx17
)
