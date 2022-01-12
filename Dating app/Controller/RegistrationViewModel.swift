//
//  RegistrationViewModel.swift
//  Dating app
//
//  Created by Jonathan Hernandez on 12/30/21.
//


import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? {
            didSet {
                checkFormValidity()
            }
        }
        var email: String? { didSet { checkFormValidity() } }
        var password: String? { didSet { checkFormValidity() } }
        
        fileprivate func checkFormValidity() {
            let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
            bindableIsFormValid.value = isFormValid
            
        }
        
        var bindableIsFormValid = Bindable<Bool>()
    
}
