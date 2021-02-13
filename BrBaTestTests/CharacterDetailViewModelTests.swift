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
    
//    func testReturnsCorrectDetail1Text() {
//        let weightString = String(format: "%.3f", weight)
//        let expectedDetail1 = "Weight: \(weightString) Kg"
//        let actualDetail1 = vm.getDetail1Text()
//        XCTAssertEqual(expectedDetail1, actualDetail1)
//    }
//
//    func testReturnsCorrectDetail2Text() {
//        let priceString = String(format: "%.2f", price)
//        let expectedDetail2 = "Price: \(priceString) £"
//        let actualDetail2 = vm.getDetail2Text()
//        XCTAssertEqual(expectedDetail2, actualDetail2)
//    }

}


class CharacterDetailViewModel: DetailViewModel {
    let character: Character
    var delegateView: ViewModelDelegateView?
    
    init(character: Character) {
        self.character = character
    }
    
    func getDetail1Text() -> String {
        return "NAME: \(character.name)"
    }
    
    func getDetail2Text() -> String {
        let occupationsString = character.occupation.joined(separator: ", ")
        return "OCCUPATIONS: \(occupationsString)"
    }
    
    func getDetail3Text() -> String {
        return "BIRTHDAY: \(character.birthday)"
    }
    
    func getDetail4Text() -> String {
        return "STATUS: \(character.status)"
    }
    
    func getDetail5Text() -> String {
        return "PORTRAYED: \(character.portrayed)"
    }
    
    func getImageUrlString() -> String {
        return character.img
    }
    
    
}
