//
//  CellModel.swift
//  Matches
//
//  Created by Stanislav on 5/25/17.
//  Copyright © 2017 SSE. All rights reserved.
//

import UIKit

extension UIColor {
	
	static var textColor: UIColor {
		if #available(iOS 13, *) {
			return .label
		} else {
			return .black
		}
	}
	
}

/// The `DateFormatter` wrapper for convenience.
struct DurationFormatter {
	
	/// The `DateFormatter` to be wrapped.
	private let formatter = DateFormatter()
	
	/// Sets the `DateFormatter` up with given format.
	init(format: String = "HH:mm:ss") {
		formatter.calendar = Calendar(identifier: .gregorian)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = format
	}
	
	/// Returns formatted `String` for given `TimeInterval` duration.
	func string(from duration: TimeInterval) -> String {
		return formatter.string(from: Date(timeIntervalSinceReferenceDate: duration))
	}
	
}

protocol CellInfo: Equatable {
	var titleFront: String { get }
	var titleBack: String { get }
	static var allCases: [Self] { get }
}

class CellModel {
	
	enum State {
		case closed, selected, disabled
	}
	
	let title: String
	let selectedColor: UIColor
	var state: State = .closed
	
	var color: UIColor {
		switch state {
		case .closed: return .darkGray
		case .selected: return selectedColor
		case .disabled: return selectedColor.withAlphaComponent(0.25)
		}
	}
	
	var textColor: UIColor {
		switch state {
		case .closed:
			return UIColor.clear
		case .selected:
			return UIColor.textColor
		case .disabled:
			return UIColor.textColor.withAlphaComponent(0.5)
		}
	}
	
	var titleIsHidden: Bool {
		return state == .closed
	}
	
	init(title: String, selectedColor: UIColor) {
		self.title = title
		self.selectedColor = selectedColor
	}
	
}

enum CellModelGenerator<Info: CellInfo> {
	
	static var randomModels: [CellModel] {
		let infos = Info.allCases.shuffled().prefix(8)
		let colors: [UIColor] = [.red, .systemOrange, .systemYellow, .systemGreen,
								 .systemTeal, .systemBlue, .systemIndigo, .magenta]
		var models: [CellModel] = []
		for index in infos.indices {
			let info = infos[index]
			let color = colors[index]
			models.append(CellModel(title: info.titleFront,
									selectedColor: color))
			models.append(CellModel(title: info.titleBack,
									selectedColor: color))
		}
		return models.shuffled()
	}
	
}

extension CellInfo {
	
	var color: UIColor {
		switch Array(Self.allCases).firstIndex(of: self)! {
		case 0: return .red
		case 1: return .systemOrange
		case 2: return .systemYellow
		case 3: return .systemGreen
		case 4: return .systemTeal
		case 5: return .systemBlue
		case 6: return .systemPurple
		case 7: return .magenta
		default: return .brown
		}
	}
	
}

