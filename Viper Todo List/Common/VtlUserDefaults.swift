//
//  VtlIsNewUser.swift
//  Viper Todo List
//
//  Created by rColeJnr on 02/09/24.
//

import Foundation

/// Use UserDefaults to store in preferences whether this is first run
final class VtlUserDefaults {
    static let shared = VtlUserDefaults()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setNotIsNewUSer() {
        UserDefaults.standard.setValue(true, forKey: "isNewUser")
    }
    
    func didLoadInitialJson() -> Bool {
        return !UserDefaults.standard.bool(forKey: "dummyJson")
    }
    
    func setDidLoadInitialJson() {
        UserDefaults.standard.setValue(true, forKey: "dummyJson")
    }
}
