//
//  MineNavHeadView.swift
//  RxSwiftByMvvm
//
//  Created by 国投 on 2018/11/2.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MineNavHeadView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var loginLab: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXib()
    }

    func initFromXib() {
        let bundle = Bundle.init(for: MineNavHeadView.self)
        let nib = UINib.init(nibName: "MineNavHeadView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        self.addSubview(contentView)

    }


}

extension CALayer {

    func setborderWithUIColor(color: UIColor) {
        self.borderColor = color.cgColor
    }
}
