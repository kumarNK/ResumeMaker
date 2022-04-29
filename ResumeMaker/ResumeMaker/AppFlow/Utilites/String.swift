//
//  String.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Foundation

extension String {
    var isValidMobileNumber: Bool {
       let mobileNumberRegEx = "^[0-9+]{0,1}+[0-9]{5,16}$"
       let mobileNumberTest = NSPredicate(format:"SELF MATCHES %@", mobileNumberRegEx)
       return mobileNumberTest.evaluate(with: self)
    }
    
    var isValidEmailAddress: Bool {
        let emailAddressRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailAddressTest = NSPredicate(format: "SELF MATCHES %@", emailAddressRegEx)
        if emailAddressTest.evaluate(with: self) {
            return true
        }
        return false
    }
}
