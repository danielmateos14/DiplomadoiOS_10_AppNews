//
//  NewsCellTableViewCell.swift
//  10AppNews
//
//  Created by djdenielb on 23/04/22.
//

import UIKit

class NewsCellTableViewCell: UITableViewCell {

//    Variables graficas
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        Esquinas redondas para la imagen
        ivImage.layer.cornerRadius = 15
    }
    
}
