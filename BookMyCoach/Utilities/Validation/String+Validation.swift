//
//  String+Validation.swift
//
//  Created by Monu on 17/07/18.
//  Copyright © 2020 Digimoplus. All rights reserved.
//

import Foundation

extension String {
    // check if text field is empty
    func isEmpty() -> Bool {
        let whitespaceSet = CharacterSet.whitespaces
        return trimmingCharacters(in: whitespaceSet).isEmpty
    }

    var trimText: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    // MARK: - Validation methods

    func requiredValidation(message: String) throws {
        if isEmpty {
            throw generateException(message)
        }
    }

    func letterValidation(message: String) throws {
        if let value = textValue(), !value.isEmpty {
            if !(value.range(of: ValidationPreferences.letterRegEx, options: .regularExpression) == nil) {
                throw generateException(message)
            }
        }
    }

    func maxLengthValidation(length: Int, message: String) throws {
        if let value = textValue(), value.count > length, !value.isEmpty {
            throw generateException(message)
        }
    }

    func minLengthValidation(length: Int, message: String) throws {
        if let value = textValue(), value.count < length, !value.isEmpty {
            throw generateException(message)
        }
    }

    func alphaNumericValidation(message: String) throws {
        if let value = textValue(), !value.isEmpty {
            if !(value.range(of: ValidationPreferences.alphaNumericRegEx, options: .regularExpression) == nil) {
                throw generateException(message)
            }
        }
    }

    func numericValidation(message: String) throws {
        if let value = textValue(), !value.isEmpty {
            if !(value.range(of: ValidationPreferences.numericRegEx, options: .regularExpression) == nil) {
                throw generateException(message)
            }
        }
    }

    func emailValidation(message: String) throws {
        if let value = textValue(), !value.isEmpty {
            let emailTest = NSPredicate(format: "SELF MATCHES %@", ValidationPreferences.emailRegEx)
            if !emailTest.evaluate(with: value) {
                throw generateException(message)
            }
        }
    }

    func mobileNumberValidation(message: String) throws {
        if let value = textValue(), !value.isEmpty {
            if !NSPredicate(format: "SELF MATCHES %@", ValidationPreferences.mobileRegEx).evaluate(with: value) || isEmpty() {
                throw generateException(message)
            }
        }
    }

    func passwordValidation(message: String) throws {
        if let string = textValue(), !string.isEmpty {
            if !NSPredicate(format: "SELF MATCHES %@", ValidationPreferences.passwordRegEx).evaluate(with: string) || isEmpty() {
                throw generateException(message)
            }
        }
    }
    
    func matchValidation(with value: String, message: String) throws {
        if self != value {
            throw generateException(message)
        }
    }

    func characterRangeValidation(min: Int, max: Int, message: String) throws {
        if let string = textValue(), !(string.count >= min && string.count <= max), !string.isEmpty {
            throw generateException(message)
        }
    }

    func rangeValidation(min: Int, max: Int, message: String) throws {
        if !trimText.isEmpty {
            guard let numeric = Int(trimText) else {
                throw generateException(message)
            }

            if !(numeric >= min && numeric <= max) {
                throw generateException(message)
            }
        }
    }

    func textValue() -> String? {
        return trimText
    }

    // Generate error from validations
    func generateException(_ message: String) -> Error {
        return NSError(domain: ValidationPreferences.domain, code: ValidationPreferences.errorCode, userInfo: [NSLocalizedDescriptionKey: message]) as Error
    }
}
