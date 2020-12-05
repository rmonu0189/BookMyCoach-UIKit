//
//  UItextField+Extension.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 04/12/20.
//

import UIKit

extension UITextField {
    
    var trimText: String {
        guard let value = self.text else { return "" }
        return value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}
