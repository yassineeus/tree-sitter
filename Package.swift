// swift-tools-version: 5.8
// This defines the Swift Package Manager configuration for Mathematics Research References

import PackageDescription

let package = Package(
    name: "MathReferences",
    products: [
        // Define a library product that makes our references available to other packages
        .library(
            name: "MathReferences",
            targets: ["MathReferences"]),
    ],
    targets: [
        .target(name: "MathReferences",
                path: "references",
                exclude: [
                        "LICENSE",
                        "README.md",
                        "documentation.md",
                        ".gitignore",
                ],
                sources: ["fields", "types", "notes"],
                resources: [
                    .copy("docs")
                ],
                cSettings: [
                        .headerSearchPath("fields"),
                        .define("MATH_REFERENCES_VERSION", to: "\"1.0.0\""),
                ]),
    ],
    swiftLanguageVersions: [.v5]
)
