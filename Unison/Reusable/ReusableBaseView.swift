//
//  ReusableBaseView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 5/1/21.
//  Copyright © 2021 Unison. All rights reserved.
//

import UIKit

class ReusableBaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // - Should be overridden in most cases.
    func setupView() {
    }
    
}

// MARK: -
// MARK: - Common Init

fileprivate extension ReusableBaseView {
    
    private func commonInit() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupView()
    }
    
}
