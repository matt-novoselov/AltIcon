//
//  File.swift
//  AltIcon
//
//  Created by Matt Novoselov on 31/08/24.
//

import Foundation


public struct Icon: Sendable {
    public let name: String?

    public init(name: String?) {
        self.name = name
    }
}


public extension Icon {
    // Main app icon
    static let main = Icon(name: nil)
    
    // Method to resolve the original asset name.
    var iconName: String? {
        return name
    }
}
