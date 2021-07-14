//
//  ReviewViewController.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 12.07.2021.
//

import UIKit

class ReviewsViewController: BaseTableViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    var resId: String = ""
    var resTitle: String = ""
    var data: [ReviewDisplayable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initTitle()
        initBackButton()
        loadData()
    }
    
    // MARK: - init
    
    func initTitle() {
        self.title = "Reviews"
        labelTitle.text = resTitle
    }
    
    func initBackButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "arrow-left"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 11)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }

    // MARK: - data
    
    func loadData() {
        showIndicator()
        Api.reviews(resId: self.resId) { reviews in
            self.data = reviews.all
            if (self.data.count == 0) {
                self.navigationController?.popToRootViewController(animated: false)
                let alert = UIAlertController(title: "Status", message: "Any review for this restaurant yet", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.tableView.reloadData()
            }
            self.hideIndicator()
        }
    }
    
    // MARK: - action
    
}

// MARK: - table data source

extension ReviewsViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "cellReview", for: indexPath) as! ReviewTableViewCell
        let item = data[indexPath.row]
        cell.labelName?.text = item.labelUserName
        cell.labelText?.text = item.labelText
        cell.labelRating?.text = item.labelRating
        return cell
    }
    
}
