//
//  preyerCViewCell.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 27/10/2021.
//

import UIKit

class preyerCViewCell: UICollectionViewCell {
    
    @IBOutlet weak var prayImage: UIImageView!{
        didSet{
            prayImage.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var prayNames: UILabel!{
        didSet{
            prayNames.textColor = .white
            prayNames.font = UIFont(name: "Almarai-Bold", size: 16)
        }
    }
    
    @IBOutlet weak var contsnerView: UIView!
}
