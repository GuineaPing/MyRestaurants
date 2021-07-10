//
//  SearchTableViewCell.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 10.07.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func oddCell(odd:Bool) {
        self.backgroundColor = odd ? UIColor(named:"color-grey-lighter") : UIColor(named:"color-white")
    }
    
}
