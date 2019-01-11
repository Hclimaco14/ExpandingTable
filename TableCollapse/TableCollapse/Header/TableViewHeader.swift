//
//  TableViewHeader.swift
//  TableCollapse
//
//  Created by Hector Climaco on 1/11/19.
//  Copyright © 2019 Hector Climaco. All rights reserved.
//

import UIKit

protocol tapHeaderDelegadate {
    func tapSection(Section : Int)
}

class TableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var labelHeader: UILabel!
    var Delegate : tapHeaderDelegadate?
    var section : Int = 0
    
    override func awakeFromNib() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSection(_:))))
    }
    
    @objc func tapSection(_ tap : UITapGestureRecognizer)
    {
        self.Delegate?.tapSection(Section: section)
    }

}
