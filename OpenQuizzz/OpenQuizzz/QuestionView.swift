//
//  QuestionView.swift
//  OpenQuizzz
//
//  Created by VINCENT BOULANGER on 06/07/2018.
//  Copyright © 2018 fr.VincentBoulanger. All rights reserved.
//

import UIKit

class QuestionView: UIView {

	@IBOutlet private var label:UILabel!
	@IBOutlet private var icon:UIImageView!
	var title:String = "" {
		didSet {
			label.text = title
		}
	}
	enum Style {
		case correct, incorrect, standard
	}
	var style:Style = .standard {
		didSet {
			setStyle(style)
		}
	}
	private func setStyle(_ style :Style) {
		switch style {
			case .correct:
				backgroundColor = UIColor(red: 200/255.0, green: 236/255.0, blue: 160/255.0, alpha: 1)
				icon.image = UIImage(named: "Icon Correct")
				icon.isHidden = false
			case .incorrect:
				backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
				icon.image = #imageLiteral(resourceName: "Icon Error")
				icon.isHidden = false
			case.standard:
				backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
				icon.isHidden = true
		}
		
	}
}
