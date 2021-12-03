//
//  DateFormatterExtension.swift
//  MovieBrowser
//
//  Created by Kevin Varghese on 12/1/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    func movieCellDateFormat(from str: String) -> String? {
        self.dateFormat = "YYYY-MM-dd"
        guard let date = self.date(from: str) else { return nil }
        self.dateFormat = "MMMM d, YYYY"
        return self.string(from: date)
    }
    
    func movieDetailDateFormat(from str: String) -> String? {
        self.dateFormat = "YYYY-MM-dd"
        guard let date = self.date(from: str) else { return nil }
        self.dateFormat = "M/d/YY"
        return self.string(from: date)
    }
    
}
