//
//  UIBuilder.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 25/11/2021.
//

import Foundation
import UIKit

class UIBuilder {
    
    static func makeLabel(numberOfLines: Int = 1,
                          lineBreakingMode: NSLineBreakMode = .byTruncatingTail,
                          color: UIColor = .black,
                          pointSize: CGFloat = 17.0,
                          fontWeight: UIFont.Weight = .regular) -> UILabel {
        let lbl = UILabel()
        
        lbl.numberOfLines = numberOfLines
        lbl.lineBreakMode = lineBreakingMode
        lbl.textColor = color
        lbl.font = .systemFont(ofSize: pointSize, weight: fontWeight)
        lbl.text = "Loading...."
        
        return lbl
    }
    
    static func makeItalicLabel(numberOfLines: Int = 1,
                          lineBreakingMode: NSLineBreakMode = .byTruncatingTail,
                          color: UIColor = .black,
                          pointSize: CGFloat = 17.0) -> UILabel {
        let lbl = UILabel()
        
        lbl.numberOfLines = numberOfLines
        lbl.lineBreakMode = lineBreakingMode
        lbl.textColor = color
        lbl.font = .italicSystemFont(ofSize: pointSize)
        lbl.text = "Loading...."
        
        return lbl
    }
}
