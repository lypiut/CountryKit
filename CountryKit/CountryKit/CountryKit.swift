//
//  CountryKit.swift
//  CountryKit
//
//  Created by Romain on 10/04/16.
//  Copyright © 2016 Romain Rivollier. All rights reserved.
//

import Foundation

public struct Country {
    
    let code : String
    let name : String
    let flag : String
}

extension Country : CustomStringConvertible {
    
    public var description: String {
        return "code: \(code), name: \(name), flag: \(flag)"
    }
}

extension NSLocale {
    
    public class func getCurrentCountry() -> Country {
        
        let locale = NSLocale.currentLocale()
        
        if let countryCode = locale.objectForKey(NSLocaleCountryCode) as? String,
            let displayName = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode){
            
            return Country(code: countryCode, name: displayName, flag: locale.flagEmoji(countryCode))
        }
        
        return Country(code: "US", name: "United States", flag: "🇺🇸")
    }
    
    public class func getCountriesList() -> [Country] {
        
        let locale = NSLocale.currentLocale()
        let countryArray = NSLocale.ISOCountryCodes()
        
        var countriesList = [Country]()
        
        for countryCode in countryArray {
            
            if let displayNameString = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode) {
                
                let country = Country(code: countryCode, name: displayNameString, flag: locale.flagEmoji(countryCode))
                countriesList.append(country)
            }
        }
        
        countriesList.sortInPlace({ return $0.name < $1.name })
        
        return countriesList
    }
    
    public func flagEmoji(countryCode : String) -> String {
        
        let base : UInt32 = 127397
        var flag = String()
        
        for unicodeValue in countryCode.unicodeScalars {
            
            flag.append(UnicodeScalar(base + unicodeValue.value))
        }
        
        return flag
    }
    
}