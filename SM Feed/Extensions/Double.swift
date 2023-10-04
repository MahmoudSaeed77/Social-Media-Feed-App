//
//  Double.swift
//  Reben
//
//  Created by imac on 10/08/2023.
//

import Foundation

extension Double {
    var formatted2f: String {
        return String(format: "%.2f", self)
    }
}
extension Double {
    func convertDate(formate: String, lang:String) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current //Set timezone that you want
        dateFormatter.locale = NSLocale(localeIdentifier: lang ) as Locale
        dateFormatter.dateFormat = formate //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
