//
//  ViewController.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 12/02/2021.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegateView = self
        titleLabel.text = viewModel?.getTitle() ?? ""
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.tableFooterView = UIView()
    }
    
}



extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel?.getLabelTextFor(indexPath.row) ?? ""
        return cell
    }
}


extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(indexPath.row)
    }
}


extension ListViewController: ListViewModelDelegateView {
    func updateUI() {
        listTableView.reloadData()
    }
}
