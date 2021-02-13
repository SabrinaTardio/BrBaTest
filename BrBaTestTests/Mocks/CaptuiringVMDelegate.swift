//
//  CaptuiringVMDelegate.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation
@testable import BrBaTest

class CaptuiringVMDelegate: ViewModelDelegateView {
    var updateUICalled = false
    func updateUI() {
        updateUICalled = true
    }
}
