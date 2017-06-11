//
//  Country.swift
//  CountryEmoji
//
//  Created by Romain on 11/06/2017.
//

import Foundation

/// Represent a country and contains the ISO country code, the localized name (depending the device language)
/// and the flag represented by an emoji
public struct Country {
    public let code: String
    public let name: String
    public let flag: String
}

extension Country: CustomStringConvertible {

    public var description: String {
        return "code: \(code), name: \(name), flag: \(flag)"
    }
}
