//
//  HomeViewController.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 05/07/21.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - Outlets & Variables
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var viewModel: SearchViewModel
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = UIScreen.main.bounds
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.green
        
        return activityIndicator
    }()
    //MARK: - Init & viewDidLoad
    
    init(viewModel: SearchViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setBindings()
        viewModel.newCategory(parameter: 0)
        view.addSubview(activityIndicator)
    }
    //MARK: - Actions
    
    @IBAction func randomPressed(_ sender: UIButton) {
        viewModel.fetchRandomFact()
    }
    
    @IBAction func changeCategory(_ sender: UIButton) {
        //To the Right
        if sender.tag == 1{
            UIView.animate(withDuration: 0.25) {
                self.categoryLabel.transform = CGAffineTransform(translationX: 300, y: 0)
            } completion: { (completed) in
                self.categoryLabel.transform = CGAffineTransform(translationX: -600, y: 0)
                self.viewModel.newCategory(parameter: sender.tag)
                self.toTheMiddle()
            }
        } //To the Left
        else if sender.tag == (-1) {
            UIView.animate(withDuration: 0.25) {
                self.categoryLabel.transform = CGAffineTransform(translationX: -300, y: 0)
            } completion: { (completed) in
                self.categoryLabel.transform = CGAffineTransform(translationX: 600, y: 0)
                self.viewModel.newCategory(parameter: sender.tag)
                self.toTheMiddle()
            }
        }
    }
    
    @IBAction func categoryPressed(_ sender: UIButton) {
        viewModel.fetchCategory()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        viewModel.fetchSearch(query: searchTextField.text ?? "")
    }
    
    //MARK: - Methods
    
    func toTheMiddle () {
        UIView.animate(withDuration: 0.25) {
            self.categoryLabel.transform = .identity
        }
    }
    
    func setUpUI() {
        hideKeyboardWhenTapHappens()
        searchTextField.colorBorder(UIColor.systemBackground.cgColor, radius: searchTextField.bounds.height/2)
        randomButton.roundButton(radius: randomButton.bounds.height/2)
        categoryButton.roundButton(radius: categoryButton.bounds.height/2)
        searchButton.roundButton(radius: searchButton.bounds.height/2)
    }
    
    func setBindings() {
        viewModel.didStartActivity = {[weak self] in
            self?.activityIndicator.startAnimating()
        }
        viewModel.didEndActivity = {[weak self] in
            self?.activityIndicator.stopAnimating()
        }
        viewModel.changeCategory = {[weak self] category in
            //Capitalize First letter
            self?.categoryLabel.text = category.proper()
        }
        viewModel.didFailToFetch = {[weak self] errorMessage in
            let alert = UIAlertController(title: "Error:", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

