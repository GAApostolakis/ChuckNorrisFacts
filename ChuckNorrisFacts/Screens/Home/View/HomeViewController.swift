//
//  HomeViewController.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 06/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Outlets & Variables
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var factsTableView: UITableView!
    
    var viewModel: HomeViewModel
    let tableCellName = "TableViewCell"
    let tableCellIdentifier = "factsCell"
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = UIScreen.main.bounds
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.green
        return activityIndicator
    }()
    //MARK: - viewDidLoad & Init()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.roundButton(radius: searchButton.bounds.height/2)
        setBidings()
        setTableView()
        view.addSubview(activityIndicator)

    }
    //MARK: - Actions
    
    @IBAction func searchPressed(_ sender: UIButton) {
        viewModel.presentSearch()
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        viewModel.clearFacts()
    }
    //MARK: - Methods
    
    func setBidings() {
        viewModel.didStartActivity = {[weak self] in
            self?.activityIndicator.startAnimating()
        }
        viewModel.didEndActivity = {[weak self] in
            self?.activityIndicator.stopAnimating()
        }
        viewModel.didAddNewData = {[weak self] in
            self?.factsTableView.reloadData()
        }
    }
    
    func setTableView() {
        factsTableView.dataSource = self
        factsTableView.delegate = self
        factsTableView.register(
            UINib(nibName: tableCellName, bundle: nil),
            forCellReuseIdentifier: tableCellIdentifier)
    }
}
//MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.facts.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCell
        let fact = viewModel.facts.result[indexPath.row]
        
        cell.url = fact.url
        if !(fact.categories?.isEmpty ?? true) {
            for categorie in fact.categories! {
                cell.categoriesLabel?.text = "\(categorie.proper()) | "
            }
        } else {
            cell.categoriesLabel?.text = "Uncategorized |"
        }
        cell.factLabel?.text = fact.value
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
