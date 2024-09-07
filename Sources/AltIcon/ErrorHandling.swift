//
//  Untitled.swift
//  AltIcon
//
//  Created by Matt Novoselov on 31/08/24.
//

// Error types
public enum AppIconError: Error {
    case unsupportedDevice
    case alternativeIconsNotSupported
    case methodNotFound
    case setIconFailed(String)
}
