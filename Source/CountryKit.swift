//
//  CountryKit.swift
//  CountryKit
//  
//  Copyright © 2016-present Romain RIVOLLIER and contributors.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public final class CountryKit {
    
    /**
     Return the current country set on the device based on the current NSLocale
     
     - returns: a country struct that contains the current country of the device
     */
    public class func getCurrentCountry() -> Country? {
        
        let locale = NSLocale.currentLocale()
        
        guard let countryCode = locale.objectForKey(NSLocaleCountryCode) as? String,
            let displayName = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode) else {
            
            return nil
        }
        
        return Country(code: countryCode, name: displayName, flag: CountryKit.flagEmoji(countryCode))
    }
    
    /**
     Return a list of Country based on country list available
     
     - returns: An array of Country
     */
    public class func getCountriesList() -> [Country] {
        
        let locale = NSLocale.currentLocale()
        let countryArray = NSLocale.ISOCountryCodes()
        
        var countriesList = [Country]()
        
        for countryCode in countryArray {
            
            if let displayNameString = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode) {
                
                let country = Country(code: countryCode, name: displayNameString, flag: CountryKit.flagEmoji(countryCode))
                countriesList.append(country)
            }
        }
        
        countriesList.sortInPlace({ return $0.name < $1.name })
        
        return countriesList
    }

    /**
     Convert the country code into the emoji flag related to the country. 
     Thank to matt for the method in this stackoverflow response (http://stackoverflow.com/a/30403199)
     
     - parameter countryCode: An ISO country code like FR, DE, etc.
     
     - returns: A string containing the emoji flag
     */
    public class func flagEmoji(countryCode : String) -> String {
        
        let base : UInt32 = 127397
        var flag = String()
        
        for unicodeValue in countryCode.unicodeScalars {
            
            flag.append(UnicodeScalar(base + unicodeValue.value))
        }
        
        return flag
    }
}