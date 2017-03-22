//
//  BoletoTableViewCell.swift
//  HttpRequest
//
//  Created by Flavio Rabelo on 17/03/17.
//  Copyright © 2017 FagutApp. All rights reserved.
//

import UIKit

class BoletoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var codBolLabel: UILabel!
    @IBOutlet weak var anoBolLabel: UILabel!
    @IBOutlet weak var vencimentoLabel: UILabel!
    @IBOutlet weak var valorBolLabel: UILabel!
    @IBOutlet weak var bolsaLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
