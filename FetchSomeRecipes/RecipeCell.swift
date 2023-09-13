//
//  RecipeCell.swift
//  FetchSomeRecipes
//
//  Created by Sara Fryzlewicz on 9/12/23.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var foodView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
