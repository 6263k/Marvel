//
//  UIViewController+.swift
//  Marvel
//
//  Created by Даниил on 23.04.2021.
//

import UIKit

extension UIViewController {
	static var identifier: String {
		return String(describing: self)
	}
}


extension UIScrollView {
	func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
		self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
	}
}
