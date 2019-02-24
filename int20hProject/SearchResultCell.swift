//
//  CustomCell.swift
//  int20hProject
//
//  Created by Ivan Karpets on 2/23/19.
//  Copyright © 2019 Nikita Skrypchenko . All rights reserved.
//

import Foundation
import UIKit

import UIKit

class SearchResultCell: UITableViewCell {
    
        var nameLabel: UILabel!
        var artistNameLabel: UILabel!
        var artworkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 220/255, green: 10/255, blue: 10/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

