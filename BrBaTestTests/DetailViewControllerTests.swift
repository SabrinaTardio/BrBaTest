//
//  DetailViewControllerTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class DetailViewControllerTests: XCTestCase {

    var vc: DetailViewController!
    var vm: MockDetailViewModel!
    let expectedDetail1 = "some detail 1 \(Date())"
    let expectedDetail2 = "some detail 2 \(Date())"
    let expectedDetail3 = "some detail 3 \(Date())"
    let expectedDetail4 = "some detail 4 \(Date())"
    let expectedDetail5 = "some detail 5 \(Date())"
    let expectedurl = "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"

    override func setUp() {
        vm = MockDetailViewModel(detail1: expectedDetail1, detail2: expectedDetail2, detail3: expectedDetail3, detail4: expectedDetail4, detail5: expectedDetail5, imgURL: expectedurl)
        vc = ViewControllersFactory().makeDetailViewController(detailViewModel: vm) as? DetailViewController
        vc.viewModel = vm
        vc.displayOnScreen()
    }

    override func tearDown() {
        vc = nil
        vm = nil
    }
    

    func testShowsCorrectDetail1() {
        let actualdetail1 = vc.label1.text
        XCTAssertEqual(expectedDetail1, actualdetail1)
    }
    
    func testShowsCorrectDetail2() {
        let actualdetail2 = vc.label2.text
        XCTAssertEqual(expectedDetail2, actualdetail2)
    }
    
    func testShowsCorrectDetail3() {
        let actualdetail3 = vc.label3.text
        XCTAssertEqual(expectedDetail3, actualdetail3)
    }
    
    func testShowsCorrectDetail4() {
        let actualdetail4 = vc.label4.text
        XCTAssertEqual(expectedDetail4, actualdetail4)
    }
    
    func testShowsCorrectDetail5() {
        let actualdetail5 = vc.label5.text
        XCTAssertEqual(expectedDetail5, actualdetail5)
    }
    
    func testUploadImage() {
        //ToDo
    }
    
}




class MockDetailViewModel: DetailViewModel  {
    let detail1: String
    let detail2: String
    var detail3: String
    let detail4: String
    let detail5: String
    let imgURL: String
    public var refreshRequestedCalled = false
    
    init(detail1: String = "", detail2: String = "", detail3: String = "", detail4: String = "", detail5: String = "", imgURL: String = "") {
        self.detail1 = detail1
        self.detail2 = detail2
        self.detail3 = detail3
        self.detail4 = detail4
        self.detail5 = detail5
        self.imgURL = imgURL
    }
    
    
    func getDetail1Text() -> String {
        return self.detail1
    }
    func getDetail2Text() -> String {
        return self.detail2
    }
    func getDetail3Text() -> String {
        return self.detail3
    }
    
    func getDetail4Text() -> String {
        return self.detail4
    }
    
    func getDetail5Text() -> String {
        return self.detail5
    }
    
    func getImageUrlString() -> String {
        return self.imgURL
    }
    
}
