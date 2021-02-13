//
//  AppCoordinator.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let vcFactory = ViewControllersFactory()
    var tabBar: UITabBarController?
    let networking = URLSessionNetworking()
    let charactersManager: RemoteCharactersManager!
    let episodeManager: RemoteEpisodesManager!
    let quotesManager: QuotesManager!
    
    
    init(window: UIWindow) {
        self.window = window
        self.charactersManager = RemoteCharactersManager(networking: networking)
        self.episodeManager = RemoteEpisodesManager(networking: networking)
        self.quotesManager = RemoteQuotesManager(networking: networking)
    }
    
    
    func start() {
        tabBar = UITabBarController()
        tabBar?.tabBar.barTintColor = .black
        tabBar?.tabBar.tintColor = .white
        window.rootViewController = tabBar
        let charactersNavigationController = setupCharactersNavigationController()
        charactersNavigationController.title = "characters"
        let episodesNavigationController = setupEpisodeNavigationController()
        episodesNavigationController.title = "episodes"
        let quotesNavifationController = setupQuotesNavigationController()
        quotesNavifationController.title = "quotes"
        tabBar?.viewControllers = [charactersNavigationController, episodesNavigationController, quotesNavifationController]
   
        window.makeKeyAndVisible()
    }
    
    
    private func setupCharactersNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .black
        let charListVM = CharactersListViewModel(charactersManager: charactersManager, coordinator: self)
        let vc = vcFactory.makeListViewController(listViewModel: charListVM)
        navController.viewControllers = [vc]
        return navController
    }
    
    private func setupEpisodeNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .black
        let episodesListVM = EpisodesListViewModel(episodesManager: episodeManager, coordinator: self)
        let vc = vcFactory.makeListViewController(listViewModel: episodesListVM)
        navController.viewControllers = [vc]
        return navController
    }
    
    private func setupQuotesNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .black
        let quotesListVM = QuotesListViewModel(quotesManager: quotesManager, coordinator: self)
        let vc = vcFactory.makeListViewController(listViewModel: quotesListVM)
        navController.viewControllers = [vc]
        return navController
    }
    
  
    
}

protocol Coordinator {
    func showDetailViewControllerWith<T>(_ object: T)
}


extension AppCoordinator: ListViewModelDelegateCoordinator {
    func showDetailViewControllerWith<T>(_ object: T) {
        var detailVM: DetailViewModel
        switch object {
        case is Character:
            detailVM = CharacterDetailViewModel(character: object as! Character)
        case is Episode:
            detailVM = EpisodeDetailViewModel(episode: object as! Episode)
        case is Quote:
            detailVM = QuoteDetailViewModel(quote: object as! Quote)
        default:
            return
        }
        let vc = vcFactory.makeDetailViewController(detailViewModel: detailVM)
        let currentViewController = tabBar?.selectedViewController
        currentViewController?.show(vc, sender: currentViewController)
    }
}
