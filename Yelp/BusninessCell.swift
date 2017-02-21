//
//  BusninessCell.swift
//  Yelp
//
//  Created by Apple on 2/18/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusninessCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    var business:Business!{
        didSet{
        nameLabel.text = business.name
            thumbImageView.setImageWith(business.imageURL!)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            reviewCountLabel.text = "\(business.reviewCount!)Reviews"
            ratingImageView.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance

        
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius=3
        thumbImageView.clipsToBounds = true
        nameLabel.sizeToFit()
        addressLabel.sizeToFit()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
