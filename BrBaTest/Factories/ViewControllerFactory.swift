//
//  ListViewControllerFactory.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import UIKit

class ViewControllersFactory: ListViewControllerFactory, DetailViewControllerFactory {
    
    func makeListViewController(listViewModel: ListViewModel) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle(for: type(of: self)))
        let listViewController = storyboard.instantiateViewController(identifier: "ListViewController") as! ListViewController
        listViewController.viewModel = listViewModel
        return listViewController
    }
    
    func makeDetailViewController(detailViewModel: DetailViewModel) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle(for: type(of: self)))
        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailViewController.viewModel = detailViewModel
        return detailViewController
    }
    
}

protocol ListViewControllerFactory{
    func makeListViewController(listViewModel: ListViewModel) -> UIViewController
}

protocol DetailViewControllerFactory{
    func makeDetailViewController(detailViewModel: DetailViewModel) -> UIViewController
}
