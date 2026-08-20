// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "2.2.0"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "ceb249e9449f36fff6392a930521b9c541bb3811a4976b8672fdb9e4eca211a4"
    static let FaceTecSDKChecksum = "373135f7fabfc11581599c7a27814b1f0400018ef2e253a18321afa197c942b6"
    static let iDenfyLivenessChecksum = "d25f37f33096d5f2be9cd0b32208c16dd1db1e4854fb6c30846ebef049c2221e"
    static let idenfyviewsChecksum = "77a08b9e00b35ab835e9fa6dfa4a84f06fbfb4de828ff822daa20d00bc7b19f2"
    static let iDenfySDKChecksum = "ab1164a3fee9bcd02cbe79f9abb4ee4af19e1a7f13c5c141f77a5d484625259e"
    static let idenfycoreChecksum = "72a87d7ed060aedf6159932cc94b80e1ac8a32a470ca679b2a04ebbe9f5df0d9"
    static let iDenfyBlurGlareDetectionChecksum = "289539418ffa4338e997b504aa01bf8f25d79b1ad4907cf0c4abd2230a831759"
}

let package = Package(
    name: "iDenfyBlurGlareDetection",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "iDenfyBlurGlareDetection-Dynamic",
            type: .dynamic,
            targets: ["iDenfySDKTarget"]),
        .library(
            name: "iDenfyBlurGlareDetection",
            targets: ["iDenfySDKTarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.0"),
    ],
    targets: [
        //iDenfyBlurGlareDetection
        .target(
            name: "iDenfyBlurGlareDetectionTarget",
            dependencies: [.target(name: "iDenfyBlurGlareDetectionWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfyBlurGlareDetectionWrap"
        ),
        .target(
            name: "iDenfyBlurGlareDetectionWrapper",
            dependencies: [
                .target(
                    name: "iDenfyBlurGlareDetection",
                    condition: .when(platforms: [.iOS])
                )
            ],
            path: "iDenfyBlurGlareDetectionWrapper"
        ),
        //IdenfyViews
        .target(
            name: "idenfyviewsTarget",
            dependencies: [.target(name: "idenfyviewsWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/idenfyviewsWrap"
        ),
        .target(
            name: "idenfyviewsWrapper",
            dependencies: [
                .target(
                    name: "idenfyviews",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
            ],
            path: "idenfyviewsWrapper"
        ),
        //IdenfyLiveness
        .target(
            name: "IdenfyLivenessTarget",
            dependencies: [.target(name: "IdenfyLivenessWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/IdenfyLivenessWrap"
        ),
        .target(
            name: "IdenfyLivenessWrapper",
            dependencies: [
                .target(
                    name: "IdenfyLiveness",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "IdenfyLivenessWrapper"
        ),
        //iDenfySDK
        .target(
            name: "iDenfySDKTarget",
            dependencies: [.target(name: "iDenfySDKWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfySDKWrap",
            cSettings: [
                .define("CLANG_MODULES_AUTOLINK", to: "YES"),
            ]
        ),
        .target(
            name: "iDenfySDKWrapper",
            dependencies: [
                .target(
                    name: "iDenfySDK",
                    condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .target(name: "iDenfyInternalLogger",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "IdenfyLivenessTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "iDenfyBlurGlareDetectionTarget",
                        condition: .when(platforms: [.iOS]))
            ],
            path: "iDenfySDKWrapper"
        ),
        // Binaries
        .binaryTarget(name: "iDenfyInternalLogger",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/iDenfyBlurGlareDetection/iDenfyInternalLogger.zip", checksum: Checksums.iDenfyInternalLoggerChecksum),
        .binaryTarget(name: "FaceTecSDK",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/iDenfyBlurGlareDetection/FaceTecSDK.zip", checksum: Checksums.FaceTecSDKChecksum),
        .binaryTarget(name: "IdenfyLiveness",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/iDenfyBlurGlareDetection/IdenfyLiveness.zip", checksum: Checksums.iDenfyLivenessChecksum),
        .binaryTarget(name: "idenfyviews",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/iDenfyBlurGlareDetection/idenfyviews.zip", checksum: Checksums.idenfyviewsChecksum),
        .binaryTarget(name: "iDenfySDK",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/iDenfyBlurGlareDetection/iDenfySDK.zip", checksum: Checksums.iDenfySDKChecksum),
        .binaryTarget(name: "idenfycore",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/iDenfyBlurGlareDetection/idenfycore.zip", checksum: Checksums.idenfycoreChecksum),
        .binaryTarget(name: "iDenfyBlurGlareDetection",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/iDenfyBlurGlareDetection/iDenfyBlurGlareDetection.zip", checksum: Checksums.iDenfyBlurGlareDetectionChecksum),
    ]
)
