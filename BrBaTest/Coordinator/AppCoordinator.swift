//
//  AppCoordinator.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let vcFactory = ViewControllersFactory()
    let vmFactory: ViewModelsFactory
    var tabBar: UITabBarController?

    
    init(window: UIWindow) {
        self.window = window
        let networking = URLSessionNetworking()
        let charactersManager = RemoteCharactersManager(networking: networking)
        let episodesManager = RemoteEpisodesManager(networking: networking)
        let quotesManager = RemoteQuotesManager(networking: networking)
        self.vmFactory = ViewModelsFactory(charactersManager: charactersManager, episodesManager: episodesManager, quotesManager: quotesManager)
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
        let charListVM = vmFactory.makeListViewModel(viewModelType: .characters, coordinator: self)
        let vc = vcFactory.makeListViewController(listViewModel: charListVM)
        navController.viewControllers = [vc]
        return navController
    }
    
    private func setupEpisodeNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .black
        let episodesListVM = vmFactory.makeListViewModel(viewModelType: .episodes, coordinator: self)
        let vc = vcFactory.makeListViewController(listViewModel: episodesListVM)
        navController.viewControllers = [vc]
        return navController
    }
    
    private func setupQuotesNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .black
        let quotesListVM = vmFactory.makeListViewModel(viewModelType: .quotes, coordinator: self)
        let vc = vcFactory.makeListViewController(listViewModel: quotesListVM)
        navController.viewControllers = [vc]
        return navController
    }
}

extension AppCoordinator: ListViewModelDelegateCoordinator {
    func showDetailViewControllerWith<T>(_ object: T) {
        let detailVM = vmFactory.makeDetailViewModel(object: object)
        let vc = vcFactory.makeDetailViewController(detailViewModel: detailVM)
        let currentViewController = tabBar?.selectedViewController
        currentViewController?.show(vc, sender: currentViewController)
    }
}
