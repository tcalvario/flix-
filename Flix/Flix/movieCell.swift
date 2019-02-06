//
//  movieCell.swift
//  Flix
//
//  Created by Teodoro Calvario on 2/6/19.
//  Copyright © 2019 Teodoro Calvario. All rights reserved.
//

import UIKit
import AlamofireImage

class movieCell: UITableViewCell {


    @IBOutlet weak var movieImages: UIImageView!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
