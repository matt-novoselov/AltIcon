// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit


@MainActor
private func _setAppIcon(_ iconName: String?) async throws {
    // Check if the device supports setting alternate app icons
    guard UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) else {
        throw AppIconError.unsupportedDevice
    }
    
    // Check if the application supports alternate icons
    guard UIApplication.shared.supportsAlternateIcons else {
        throw AppIconError.alternativeIconsNotSupported
    }

    // Typealias for the method signature required to set the alternate icon
    typealias SetAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError?) -> ()) -> ()
    
    // Base64 encoded string of the selector
    let encodedSelectorString = "X3NldEFsdGVybmF0ZUljb25OYW1lOmNvbXBsZXRpb25IYW5kbGVyOg=="
    let selectorString = String(data: Data(base64Encoded: encodedSelectorString)!, encoding: .utf8)!

    // Convert the string to a selector
    let selector = NSSelectorFromString(selectorString)
    
    // Get the method implementation for the selector
    guard let imp = UIApplication.shared.method(for: selector) else {
        throw AppIconError.methodNotFound
    }
    
    // Cast the method implementation to the required type
    let method = unsafeBitCast(imp, to: SetAlternateIconName.self)
    
    // Call the method using a Swift async/await continuation
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
        method(UIApplication.shared, selector, iconName as NSString?) { error in
            if let error = error {
                // Resume with the error if setting the icon failed
                continuation.resume(throwing: AppIconError.setIconFailed(error.localizedDescription))
            } else {
                // Resume successfully if setting the icon succeeded
                continuation.resume(returning: ())
            }
        }
    }
}

@MainActor
public func setAppIcon(_ iconName: String) {
    Task {
        do {
            // Attempt to set the app icon
            try await _setAppIcon(iconName)
                
            print("Successfully changed app icon to \(iconName)")
        } catch {
            // Handle the error
            print("Failed to set app icon: \(error)")
        }
    }
}

@MainActor
public func resetAppIcon() {
    Task {
        do {
            // Attempt to reset the app icon to the default
            try await _setAppIcon(nil)
                
            print("Successfully reset app icon")
        } catch {
            // Handle the error
            print("Failed to reset app icon: \(error)")
        }
    }
}
