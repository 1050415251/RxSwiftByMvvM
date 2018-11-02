//
//  FirstPageTableViewCell.swift
//  RxSwiftByMvvm
//
//  Created by 国投 on 2018/11/2.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import Foundation
import UIKit

class FirstPageTableViewCell: UITableViewCell {


    @IBOutlet weak var textlabel: UILabel!


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // fatalError("init(coder:) has not been implemented")
    }

}
