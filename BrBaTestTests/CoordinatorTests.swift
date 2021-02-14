//
//  CoordinatorTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 14/02/2021.
//

// Not complete did not have time

import XCTest
@testable import BrBaTest

class CoordinatorTests: XCTestCase {
    let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first!
    var coordinator: Coordinator!
    
    override func setUp() {
        coordinator = AppCoordinator(window: window)
        coordinator.start()
    }

    func testOnStartThereIsATabBar() {
        let tabBar = window.rootViewController as? UITabBarController
        let NC1 = tabBar?.viewControllers?[0] as? UINavigationController
        let VC1 = NC1?.visibleViewController as? ListViewController
        let NC2 = tabBar?.viewControllers?[1] as? UINavigationController
        let VC2 = NC2?.visibleViewController as? ListViewController
        let NC3 = tabBar?.viewControllers?[2] as? UINavigationController
        let VC3 = NC3?.visibleViewController as? ListViewController
        XCTAssertEqual(tabBar?.tabBar.items?.count, 3)
        XCTAssertTrue(VC1?.viewModel is CharactersListViewModel)
        XCTAssertTrue(VC2?.viewModel is EpisodesListViewModel)
        XCTAssertTrue(VC3?.viewModel is QuotesListViewModel)
    }
    

//TODO: Rewrite coordinator properly
    
}
