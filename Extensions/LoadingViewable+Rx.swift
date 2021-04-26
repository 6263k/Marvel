//
//  LoadingViewable+Rx.swift
//  Marvel
//
//  Created by Даниил on 25.04.2021.
//

import RxSwift

extension Reactive where Base: UIViewController & LoadingViewable {
	
	var isAnimating: Binder<Bool> {
		return Binder(self.base, binding: { (vc, active) in
			if active {
				vc.startAnimating()
			} else {
				vc.stopAnimating()
			}
		})
	}
}
