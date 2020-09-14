//
//  WaveformView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/13/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit

class WaveformView: UIView {
    
    // - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = Bundle(for: type(of: self)).loadNibNamed("WaveformView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        //configure()
    }

}
