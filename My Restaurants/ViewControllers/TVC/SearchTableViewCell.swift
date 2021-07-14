//
//  SearchTableViewCell.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 10.07.2021.
//

import UIKit

protocol SearchTableViewCellProtocol: AnyObject {
    func favoritesChanged(resId: String, isFavorite: Bool)
}

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    weak var delegate: SearchTableViewCellProtocol?
    private var _isFavorite : Bool = false
    var isFavorite: Bool {
        set {
           _isFavorite = newValue
            let imageName = (_isFavorite) ? "checked" : "unchecked"
            if let image = UIImage(named:imageName) {
                self.buttonFavorite.setImage(image, for: .normal)
            }
        }
        get {
           return _isFavorite
        }
    }
    var resId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func oddCell(odd:Bool) {
        self.backgroundColor = odd ? UIColor(named:"color-grey-lighter") : UIColor(named:"color-white")
    }
    
    @IBAction func actionFavorites(_ sender: Any) {
        guard (delegate != nil) else {
            return
        }
        isFavorite = !isFavorite
        delegate?.favoritesChanged(resId: self.resId, isFavorite: self.isFavorite)
    }
}
