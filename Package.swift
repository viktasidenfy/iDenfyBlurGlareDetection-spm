// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "2.1.0"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "6b457eff71e201bc439d81c7ddafef26f0c3a6cd984325bc77e52d5f6c0afb40"
    static let FaceTecSDKChecksum = "2b78816dbacd5798788f572cfd9a0471dcb19377950d7dcf51bcea13005f2592"
    static let iDenfyLivenessChecksum = "0ae536b292d96a0ddb6e55d45b1417fc63dd6521d5e15145ca54a6cfd4a58408"
    static let idenfyviewsChecksum = "73b794a7749e15de5ffe98f0a1a7485c2b14135ad2566701864f2576365e8eea"
    static let iDenfySDKChecksum = "1cf02792cf85bc2e7857ee54b0c11a0da5ac4025a236078b13e9cbdef7228437"
    static let idenfycoreChecksum = "5227aa43899a8afc2e8811c4698410f8f74c5f5bcc6d9322e8dde3ed073ae039"
    static let iDenfyBlurGlareDetectionChecksum = "2a8194350aa8823d96d619fd0ee524877136b6448f14f128531262675a8ed66e"
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
        .package(url: "https://github.com/airbnb/lottie-spm.git", "4.5.0"..<"4.5.1"),
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
