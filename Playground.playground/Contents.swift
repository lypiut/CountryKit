//: CountryEmoji Playground

import Cocoa
import CountryEmoji

let locale = Locale(identifier: "fr")
let countryEmoji = CountryEmoji(locale: locale)

//: Get current country
let current = countryEmoji.current

//: Get all countries
let allcountries = countryEmoji.generateCountryList()

let indexes = allcountries
        .map { String($0.name.folding(options: .diacriticInsensitive, locale: locale).prefix(1)) }
        .reduce([String](), { $0.contains($1) ? $0 : $0 + [$1] })

var mapping = [String: Array<Country>]()

for index in indexes {

    mapping[index] = allcountries.filter { $0.name.folding(options: .diacriticInsensitive, locale: locale).prefix(1) == index }

}
/*
allcountries
    .map { (String($0.name.folding(options: .diacriticInsensitive, locale: locale).prefix(1)), $0) }
    .forEach { (key) in
        if mapping[key.0] == nil { mapping[key.0] = Array()}
        mapping[key.0]?.append(key.1)
    }
*/
print(mapping)
