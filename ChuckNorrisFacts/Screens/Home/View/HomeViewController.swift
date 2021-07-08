//
//  HomeViewController.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 06/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var chukyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.roundButton()
        searchButton.titleLabel?.numberOfLines = 0
        // Do any additional setup after loading the view.
    }
}

