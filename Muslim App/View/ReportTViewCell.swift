//
//  ReportTViewCell.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 14/12/2021.
//

import UIKit
import KDCircularProgress

class ReportTViewCell: UITableViewCell {

    @IBOutlet weak var progressCircle: KDCircularProgress!
    
    @IBOutlet weak var lblOfAzkarAndPray: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
