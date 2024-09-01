// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit


@MainActor
private func _setAppIcon(_ iconName: String?) async throws {
    guard UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) else {
        throw AppIconError.unsupportedDevice
    }
    
    guard UIApplication.shared.supportsAlternateIcons else {
        throw AppIconError.unsupportedDevice
    }

    typealias SetAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError?) -> ()) -> ()
    
    let encodedSelectorString = "X3NldEFsdGVybmF0ZUljb25OYW1lOmNvbXBsZXRpb25IYW5kbGVyOg=="
    let selectorString = String(data: Data(base64Encoded: encodedSelectorString)!, encoding: .utf8)!

    let selector = NSSelectorFromString(selectorString)
    
    guard let imp = UIApplication.shared.method(for: selector) else {
        throw AppIconError.methodNotFound
    }
    
    let method = unsafeBitCast(imp, to: SetAlternateIconName.self)
    
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
        method(UIApplication.shared, selector, iconName as NSString?) { error in
            if let error = error {
                continuation.resume(throwing: AppIconError.setIconFailed(error.localizedDescription))
            } else {
                continuation.resume(returning: ())
            }
        }
    }
}


@MainActor
public func setAppIcon(_ iconName: Icon) {
    Task {
        do {
            // Resolve icon name
            let resolvedIconName = iconName.iconName
            
            // Try to set app icon
            try await _setAppIcon(resolvedIconName)
                
            print("Successfully changed app icon to \(resolvedIconName ?? "main")")
        } catch {
            // Handle the error
            print("Failed to set app icon: \(error)")
        }
    }
}
