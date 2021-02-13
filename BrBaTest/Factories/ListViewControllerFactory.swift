//
//  ListViewControllerFactory.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import UIKit

class ViewControllersFactory {
    
    func makeListViewController(fruitListViewModel: ListViewModel) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle(for: type(of: self)))
        let listViewController = storyboard.instantiateViewController(identifier: "ListViewController") as! ListViewController
        listViewController.viewModel = fruitListViewModel
        return listViewController
    }
    
    func makeDetailViewController(detailViewModel: DetailViewModel) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle(for: type(of: self)))
        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailViewController.viewModel = detailViewModel
        return detailViewController
    }
    
}
