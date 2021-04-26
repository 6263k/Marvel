//
//  TableView+Rx.swift
//  Marvel
//
//  Created by Даниил on 26.04.2021.
//

import RxSwift

extension Reactive where Base: UITableView {
	
	var keyboardHeight: Observable<CGFloat> {
		return Observable.from([
			NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
				.map { notification -> CGFloat in
					(notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 
				},
			NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
				.map {_ -> CGFloat in
					0
				}
		])
		.merge()
	}
	
}
