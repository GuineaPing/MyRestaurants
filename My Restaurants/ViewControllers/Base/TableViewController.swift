//
//  BaseTableViewController.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 12.07.2021.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwipe()
    }
    
    // MARK: - inits
    
    func initSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(goBack))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    // MARK: - load indicator
    
    func showIndicator() {
        
        activityIndicator = UIActivityIndicatorView(frame:CGRect(x: 100, y: 100, width: 100, height: 100)) as UIActivityIndicatorView
        self.activityIndicator.style = UIActivityIndicatorView.Style.large
        self.activityIndicator.center = self.view.center;
        self.navigationController?.view.addSubview(activityIndicator)
        self.tableView?.bringSubviewToFront(activityIndicator)
        self.activityIndicator.startAnimating();
    }
    
    func hideIndicator() {
        activityIndicator.removeFromSuperview();
    }
    
    // MARK: - actions
    
    @objc func goBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
