//
//  ListViewControllerFactory.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import UIKit

class ListViewControllersFactory {
    
    func makeListViewController(fruitListViewModel: ListViewModel) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle(for: type(of: self)))
        let fruitListViewController = storyboard.instantiateViewController(identifier: "ListViewController") as! ListViewController
        fruitListViewController.viewModel = fruitListViewModel
        return fruitListViewController
    }
    
}
