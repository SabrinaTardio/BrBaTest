//
//  DetailViewController.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var featureImageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var labelsStackView: UIStackView!
    
    var viewModel: DetailViewModel? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabelsAndImage()
    }
    
    private func updateLabelsAndImage() {
        label1.text = viewModel?.getDetail1Text() ?? ""
        label2.text = viewModel?.getDetail2Text() ?? ""
        label3.text = viewModel?.getDetail3Text() ?? ""
        label4.text = viewModel?.getDetail4Text() ?? ""
        label5.text = viewModel?.getDetail5Text() ?? ""

    }
    



}
