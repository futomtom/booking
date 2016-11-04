//
//  ItemCell.swift
//  DynoOrder
//
//  Created by alexfu on 10/20/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var name: UILabel!
   
   
    let colors = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.cyan, UIColor.gray,UIColor.brown, UIColor.orange ]
    
    
    override func awakeFromNib() {
        
        layer.borderColor=UIColor.darkGray.cgColor
        layer.borderWidth=1
        layer.cornerRadius = 4
    }
    

    
}






