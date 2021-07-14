//
//  SearchTableViewCell.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 10.07.2021.
//

import UIKit

protocol SearchTableViewCellProtocol: AnyObject {
    func favoritesChanged(resId: String, isFavorite: Bool)
    func callReviews(resId: String, resTitle: String)
    func callMap(resId: String)
}

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var buttonReviews: UIButton!
    @IBOutlet weak var buttonMap: UIButton!
    
    weak var delegate: SearchTableViewCellProtocol?
    
    private var _isFavorite : Bool = false
    var isFavorite: Bool {
        set {
           _isFavorite = newValue
            let imageName = (newValue) ? "checked" : "unchecked"
            if let image = UIImage(named:imageName) {
                self.buttonFavorite.setImage(image, for: .normal)
            }
        }
        get {
           return _isFavorite
        }
    }
    
    var totalReviews : Int = 0
    var resId: String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func oddCell(odd:Bool) {
        backgroundColor = odd ? UIColor(named:"color-grey-lighter") : UIColor(named:"color-white")
        let buttonBackground: UIColor? = odd ? UIColor(named:"color-white") : UIColor(named:"color-grey-lighter")
        buttonReviews.backgroundColor = buttonBackground
        buttonMap.backgroundColor = buttonBackground
    }

    @IBAction func actionFavorites(_ sender: Any) {
        guard (delegate != nil) else {
            return
        }
        isFavorite = !isFavorite
        delegate?.favoritesChanged(resId: self.resId, isFavorite: self.isFavorite)
    }
    
    @IBAction func actionReviews(_ sender: Any) {
        guard (delegate != nil) else {
            return
        }
        delegate?.callReviews(resId: self.resId, resTitle: self.labelTitle.text ?? "")
    }

    @IBAction func actionMap(_ sender: Any) {
        guard (delegate != nil) else {
            return
        }
        delegate?.callMap(resId: self.resId)
    }
}
