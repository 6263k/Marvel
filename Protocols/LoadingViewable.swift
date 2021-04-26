//
//  loadingViewable.swift
//  Marvel
//
//  Created by Даниил on 25.04.2021.
//

import UIKit

protocol LoadingViewable {
	func startAnimating()
	func stopAnimating()
}

private enum Constants {
	static let loadingViewRestorationId = "loadingView"
}

extension LoadingViewable where Self: UIViewController {
	
	func startAnimating() {
		if view.subviews.contains(where: { $0.restorationIdentifier == Constants.loadingViewRestorationId }) { return }
		
		let loadingView = UIActivityIndicatorView(frame: view.bounds)
		loadingView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
		loadingView.style = .large
		loadingView.color = .green
		
		view.addSubview(loadingView)
		view.bringSubviewToFront(loadingView)
		loadingView.restorationIdentifier = Constants.loadingViewRestorationId
		loadingView.startAnimating()
	}
	
	func stopAnimating() {
		for item in view.subviews where item.restorationIdentifier == Constants.loadingViewRestorationId {
			UIView.animate(withDuration: 0.1, animations: {
				item.alpha = 0
			}) { (_) in
				item.removeFromSuperview()
			}
		}
	}
}

