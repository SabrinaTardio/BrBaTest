//
//  CaptuiringVMDelegate.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation
@testable import BrBaTest

class CaptuiringVMDelegate: ListViewModelDelegateView {
    var updateUICalled = false
    func updateUI() {
        updateUICalled = true
    }
}
