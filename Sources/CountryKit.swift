import Foundation

public final class CountryKit {

    private let locale: Locale

    /// Current region
    public var current: Country? {
        guard let regionCode = locale.regionCode,
              let localizedRegion = locale.localizedString(forRegionCode: regionCode) else {
            return nil
        }

        return Country(code: regionCode, name: localizedRegion, flag: getEmojiFlag(for: regionCode))
    }

    /// Create a new instance of the class
    ///
    /// - Parameter locale: the locale to use, by defaut use current locale
    public init(locale: Locale = Locale.current) {
        self.locale = locale
    }

    public func generateCountryIndexes() -> [String: Array<Country>] {

        var mapping = [String: Array<Country>]()
        generateCountryList()
            .map { (String($0.name.folding(options: .diacriticInsensitive, locale: locale).prefix(1)), $0) }
            .forEach { (key) in
                if mapping[key.0] == nil { mapping[key.0] = Array() }
                mapping[key.0]?.append(key.1)
            }

        return mapping
    }

    /// Generate and return all regions available on the device
    ///
    /// - Returns: A sorted array of Country object
    public func generateCountryList() -> [Country] {
        return Locale.isoRegionCodes
            .flatMap { (regionCode) -> Country? in
                guard let localizedRegion = locale.localizedString(forRegionCode: regionCode) else { return nil }
                return Country(code: regionCode, name: localizedRegion, flag: getEmojiFlag(for: regionCode))
            }.sorted(by: { $0.name < $1.name })
    }

    /// Convert the region code to the country emoji flag
    ///
    /// - Parameter regionCode: the region code to convert
    /// - Returns: a string that contains the country emojie
    func getEmojiFlag(for regionCode: String) -> String {
        return regionCode.unicodeScalars
            .flatMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
}
