//
//  CharacterListViewModelTests.swift
//  BrBaTestTests
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import XCTest
@testable import BrBaTest

class CharacterListViewModelTests: XCTestCase {

    var charactersManager: MockCharactersManager!
    var vm: ListViewModel!
    var capturingCoordinator: CapturingCoordinator!
    let characters = [Character.fixture(name: "prova"), Character.fixture(name: "prova2"), Character.fixture()]
    let updatedCharacters = [Character.fixture(name: "something"), Character.fixture()]
    
    override func setUp() {
        charactersManager  = MockCharactersManager(charactersResponse: characters)
        capturingCoordinator = CapturingCoordinator()
        vm = CharactersListViewModel(charactersManager: charactersManager, coordinator: capturingCoordinator)
    }
    
    func testReturnsExpectedTitle() {
        let expectedTitle = "Characters"
        XCTAssertEqual(expectedTitle, vm.getTitle())
    }
    
    func testReturnCorrectNumberOfRows() {
        charactersManager.performCompletion()
        let actualNumberOfRows = vm.getNumberOfRows()
        XCTAssertEqual(actualNumberOfRows, characters.count)
    }
    
    func testReturnCorrectLabelText() {
        charactersManager.performCompletion()
        let selectedIndex = Int.random(in: 0..<characters.count)
        let actualLabelText = vm.getLabelTextFor(selectedIndex)
        XCTAssertEqual(actualLabelText, characters[selectedIndex].name)
    }

    func testOnDidSelectRawAskCoordinatorToChangeScreenWithSelectedCharacter() {
        charactersManager.performCompletion()
        let selectedIndex = Int.random(in: 0..<characters.count)
        vm.didSelectRow(selectedIndex)

        XCTAssertEqual(capturingCoordinator.selectedCharacter, characters[selectedIndex])
    }
    
    func testOnCharactersManagerCallBackWarnsTheDelegateView() {
        let delegate = CaptuiringVMDelegate()
        vm.delegateView = delegate
        charactersManager.performCompletion()
        XCTAssertTrue(delegate.updateUICalled)
    }
    
    func testDelegateViewIsNotRetained() {
        var delegate: ViewModelDelegateView? = CaptuiringVMDelegate()
        weak var weakDelegate = delegate
        vm.delegateView = delegate
        delegate = nil
        
        XCTAssertNil(weakDelegate)
    }
    
    func testDelegateCoordinatorIsNotRetained() {
        var delegate: ListViewModelDelegateCoordinator? = CapturingCoordinator()
        weak var weakDelegate = delegate
        vm.delegateCoordinator = delegate
        delegate = nil
        
        XCTAssertNil(weakDelegate)
    }


}

extension Character {
    static func fixture(name: String = "SomeName") -> Character {
        return Character(name: name, occupation: [""], birthday: "", status: "", portrayed: "", img: "")
    }
}
