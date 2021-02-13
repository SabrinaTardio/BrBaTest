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
//        vm = ListViewModelFactory(fruitManager: fruitManager).makeTableListViewModel(with: capturingCoordinator)
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
    
    func testOnCharactersManagerCallBackWarnsTheDelegate() {
        let delegate = CaptuiringVMDelegate()
        vm.delegate = delegate
        charactersManager.performCompletion()
        XCTAssertTrue(delegate.updateUICalled)
    }
    
    func testDelegateIsNotRetained() {
        var delegate: ListViewModelDelegate? = CaptuiringVMDelegate()
        weak var weakDelegate = delegate
        vm.delegate = delegate
        delegate = nil
        
        XCTAssertNil(weakDelegate)
    }


}



protocol CharactersManager {
    func fetchCharacters(completion: @escaping ([Character]) -> ())
}

class MockCharactersManager: CharactersManager {
    var characters: [Character]
    var completion: (([Character]) -> ())?
    
    init(charactersResponse: [Character] = []) {
        self.characters = charactersResponse
    }
    
    func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        self.completion = completion
    }
    
    func performCompletion() {
        completion!(characters)
    }
    
}

class BrBaCharactersManager: CharactersManager{
    func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        
    }
}

protocol Coordinator: class {
    func showDetailViewControllerWith<T>(_ object: T)
}

class CapturingCoordinator: Coordinator {
    var selectedCharacter: Character?
    
    func showDetailViewControllerWith<T>(_ object: T) {
        selectedCharacter = object as? Character
    }
}

struct Character {
    let name: String
}

extension Character: Equatable {
    static func fixture(name: String = "SomeName") -> Character {
        return Character(name: name)
    }
}

class CaptuiringVMDelegate: ListViewModelDelegate {
    var updateUICalled = false
    func updateUI() {
        updateUICalled = true
    }
}


class CharactersListViewModel: ListViewModel {
    weak var delegate: ListViewModelDelegate?
    let charactersManager: CharactersManager
    weak var coordinator: Coordinator?
    var characters: [Character] = []
    
    init(charactersManager: CharactersManager = BrBaCharactersManager(), coordinator: Coordinator) {
        self.charactersManager = charactersManager
        self.coordinator = coordinator
        updateCharacters()
    }
    
    func getTitle() -> String {
        return "Characters"
    }
    
    func getNumberOfRows() -> Int {
        return characters.count
    }
    
    func getLabelTextFor(_ index: Int) -> String {
        return characters[index].name
    }
    
    func didSelectRow(_ index: Int) {
        coordinator?.showDetailViewControllerWith(characters[index])
    }
    
    private func updateCharacters() {
        self.charactersManager.fetchCharacters { (characters) in
            self.characters = characters
            self.delegate?.updateUI()
        }
    }
    
    
}
