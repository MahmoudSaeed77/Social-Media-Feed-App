//
//  String.swift
//  Reben
//
//  Created by imac on 07/08/2023.
//

import Foundation

extension String {
    public var arToEnDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
    public var enToArDigits : String {
        let numbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        numbers.map { txt = txt.replacingOccurrences(of: $1, with: $0)}
        return txt
    }
    var trimmed:String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var localized:String{
        return NSLocalizedString(self, comment: "")
    }
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    func setSpaces(spaces: String) -> String {
        return self.map{ String($0) }.joined(separator: spaces)
    }
}
