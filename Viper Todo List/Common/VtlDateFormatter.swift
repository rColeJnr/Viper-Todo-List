//
//  VtlDateFormatter.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation

final class VtlDateFormatter {
    
    static let shared:  VtlDateFormatter = VtlDateFormatter()
    
    func dateFormatter(from date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
