//
//  DayWeatherCell.swift
//  WeatherGift
//
//  Created by Kerri Shields on 3/29/17.
//  Copyright © 2017 Kerri Shields. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {

    @IBOutlet weak var cellIcon: UIImageView!
    
    @IBOutlet weak var cellWeekday: UILabel!
    
    @IBOutlet weak var cellMaxTemp: UILabel!
    
    @IBOutlet weak var cellMinTemp: UILabel!
    
    @IBOutlet weak var cellSummary: UITextView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
