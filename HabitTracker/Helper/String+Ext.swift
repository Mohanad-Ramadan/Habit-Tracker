//
//  String+Ext.swift
//  HabitTracker
//
//  Created by Mohanad Ramdan on 13/01/2025.
//

import Foundation

extension String {
    
    // map an string for better textfield UX
    func sanitizeInput(charactersLimit: Int, sanitizeDots: Bool = true) -> String {
        // If the input is empty or contains only white spaces, return an empty string
        if self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return ""
        }
        // Remove any extra spaces and keep at most one space between words
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        let filteredComponents = components.filter { !$0.isEmpty }
        
        // Join the components with a single space, preserving only one space between words
        var sanitized = filteredComponents.joined(separator: " ")
        
        // Allow a trailing space if the original input has it (for user convenience)
        if self.hasSuffix(" ") && !sanitized.hasSuffix(" ") {
            sanitized += " "
        }
        // remove '.' from the input
        if sanitizeDots {
            sanitized = sanitized.trimmingCharacters(in: CharacterSet(charactersIn: "."))
        }
        // prefix the sanitized string to characters limit
        return String(sanitized.prefix(charactersLimit))
    }
}
