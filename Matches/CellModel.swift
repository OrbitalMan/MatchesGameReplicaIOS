//
//  CellModel.swift
//  Matches
//
//  Created by Stanislav on 5/25/17.
//  Copyright © 2017 SSE. All rights reserved.
//

import UIKit

class CellModel {
	
	var state: CellState = .closed
	
	let number: CellNumber
	
	var color: UIColor {
		switch state {
		case .closed: return .darkGray
		case .selected: return number.color
		case .disabled: return .lightGray
		}
	}
	
	var titleIsHidden: Bool {
		return state == .closed ? true : false
	}
	
	init(number: CellNumber) {
		self.number = number
	}
	
}

enum CellState {
	case closed, selected, disabled
}

enum CellNumber: String {
	case one = "1"
	case two = "2"
	case three = "3"
	case four = "4"
	case five = "5"
	case six = "6"
	case seven = "7"
	case eight = "8"
	
	var color: UIColor {
		switch self {
		case .one: return .orange
		case .two: return .yellow
		case .three: return .green
		case .four: return .cyan
		case .five: return .blue
		case .six: return .purple
		case .seven: return .magenta
		case .eight: return .red
		}
	}
	
}

extension Sequence where Iterator.Element == CellModel {
	
	static var sequence: [CellModel] {
		var models: [CellModel] = []
		for n in 1...8 {
			models.append(CellModel(number: CellNumber(rawValue: String(n))!))
		}
		return models
	}
	
	static var random: [CellModel] {
		var models: [CellModel] = []
		models = sequence + sequence
		return models.shuffled
	}
	
}

extension Sequence {
	
	var shuffled: [Iterator.Element] {
		var output = Array(self)
		if output.count > 1 {
			for i in 0 ..< output.count-1 {
				let j = Int(arc4random_uniform(UInt32(output.count - i))) + i
				guard i != j else { continue }
				swap(&output[i], &output[j])
			}
		}
		return output
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


