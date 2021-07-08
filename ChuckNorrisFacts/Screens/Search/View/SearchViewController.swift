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
    }
    //MARK: - Actions
    
    @IBAction func randomPressed(_ sender: UIButton) {
        viewModel.fetchRandomFact()
    }
    
    @IBAction func changeCategory(_ sender: UIButton) {
//        UIView.animate(withDuration: 0.25) {
//            self.categoryLabel.transform = CGAffineTransform(translationX: 300, y: 0)
////            self.categoryLabel.frame = CGRect(x: 600, y: self.categoryLabel.bounds.midY, width: self.categoryLabel.frame.width, height: self.categoryLabel.frame.height)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//            self.categoryLabel.transform = CGAffineTransform(translationX: -600, y: 0)
//            self.viewModel.newCategory(parameter: sender.tag)
//            self.fromLeft()
//        }
//        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear) {
//            UIView.addKeyframe(withRelativeStartTime: <#T##Double#>, relativeDuration: <#T##Double#>, animations: <#T##() -> Void#>)
//        } completion: { (<#Bool#>) in
//            <#code#>
//        }
        UIView.animate(withDuration: 0.25) {
            self.categoryLabel.transform = CGAffineTransform(translationX: 300, y: 0)
        } completion: { (completed) in
            self.categoryLabel.transform = CGAffineTransform(translationX: -600, y: 0)
            self.viewModel.newCategory(parameter: sender.tag)
            self.fromLeft()
        }
//        UIView.animate(withDuration: 0.25, delay: 0.5, options: .curveLinear) {
//            self.categoryLabel.transform = .identity
//        } completion: { (_) in
//        }
//        viewModel.newCategory(parameter: sender.tag)
    }
    
    func fromLeft () {
        UIView.animate(withDuration: 0.25) {
            self.categoryLabel.transform = .identity
//            self.categoryLabel.frame = CGRect(x: 600, y: self.categoryLabel.bounds.midY, width: self.categoryLabel.frame.width, height: self.categoryLabel.frame.height)
        }
    }
    
    @IBAction func categoryPressed(_ sender: UIButton) {
        viewModel.fetchCategory()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        viewModel.fetchSearch(query: searchTextField.text ?? "")
    }
    
    //MARK: - Methods
    
    func setUpUI() {
        searchTextField.colorBorder(UIColor.black.cgColor, radius: 4.0)
        randomButton.roundButton(radius: randomButton.bounds.height/2)
        categoryButton.roundButton(radius: randomButton.bounds.height/2)
        categoryLabel.layer.borderColor = UIColor.black.cgColor
        categoryLabel.layer.cornerRadius = 20.0
    }
    
    func setBindings() {
        viewModel.didStartActivity = {[weak self] in
            self?.activityIndicator.startAnimating()
        }
        viewModel.didEndActivity = {[weak self] in
            self?.activityIndicator.stopAnimating()
        }
        viewModel.changeCategory = {[weak self] category in
            self?.categoryLabel.text = category.proper()
        }
    }
}
