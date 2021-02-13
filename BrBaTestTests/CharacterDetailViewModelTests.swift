//
//  CharacterDetailViewModelTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import XCTest
@testable import BrBaTest

class CharacterDetailViewModelTests: XCTestCase {

    var character: Character!
    var vm: DetailViewModel!
    let expectedName = "some type \(Date())"
    let occupations = ["developer", "musician"]
    let birthday = "asd"
    let status = "prova"
    let portrayed = "by someone"
    let img = "some url"
    
    override func setUp() {
        character  = Character(name: expectedName, occupation: occupations, birthday: birthday, status: status, portrayed: portrayed, img: img)
        vm = CharacterDetailViewModel(character: character)
    }


    func testReturnsCorrectDetail1() {
        let actualDetail = vm.getDetail1Text()
        XCTAssertEqual("NAME: \(expectedName)", actualDetail)
    }
    
    func testReturnsCorrectDetail2() {
        let actualDetail = vm.getDetail2Text()
        let occupationsString = "developer, musician"
        XCTAssertEqual("OCCUPATIONS: \(occupationsString)", actualDetail)
    }
    
    func testReturnsCorrectDetail3() {
        let actualDetail = vm.getDetail3Text()
        XCTAssertEqual("BIRTHDAY: \(birthday)", actualDetail)
    }
    
    func testReturnsCorrectDetail4() {
        let actualDetail = vm.getDetail4Text()
        XCTAssertEqual("STATUS: \(status)", actualDetail)
    }
    
    func testReturnsCorrectDetail5() {
        let actualDetail = vm.getDetail5Text()
        XCTAssertEqual("PORTRAYED: \(portrayed)", actualDetail)
    }
    
    func testReturnsCorrectImgUrl() {
        let actualUrl = vm.getImageUrlString()
        XCTAssertEqual(img, actualUrl)
    }
    
}



