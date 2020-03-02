//
//  MatchesCollectionViewController.swift
//  Matches
//
//  Created by Stanislav on 5/25/17.
//  Copyright © 2017 SSE. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

private let headerId = "Header"

class MatchesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	var cellModels: [CellModel] = .random
	
	var activeCellIndex: Int? = nil
	
	var resetting: Bool = false
	
	var tapsCount: Int = 0
	
	let timeFormatter = DurationFormatter()
	
	var counter: Timer = Timer()
	
	var start: Date? = nil
	
	var progress: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		clearsSelectionOnViewWillAppear = false
	}
	
	deinit {
		counter.invalidate()
	}
	
	// MARK: IBActions
	
	@IBAction func refresh(_ sender: UIBarButtonItem) {
		counter.invalidate()
		activeCellIndex = nil
		cellModels = .random
		tapsCount = 0
		start = nil
		progress = 0
		collectionView?.reloadData()
	}
	
	// MARK: UICollectionViewDataSource
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellModels.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let model = cellModels[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MatchCollectionViewCell
		cell.layer.cornerRadius = 4
		cell.backgroundColor = model.color
		cell.titleLabel.text = model.number.rawValue
		cell.titleLabel.isHidden = model.titleIsHidden
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MatchesHeaderCollectionReusableView
		if let start = start {
			header.timeLabel.text = "Time: \(timeFormatter.string(from: Date().timeIntervalSince(start)))"
		} else {
			header.timeLabel.text = "Time: 00:00:00"
		}
		header.counterLabel.text = "Taps: \(tapsCount)"
		return header
	}
	
	// MARK: UICollectionViewDelegate
	override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		let model = cellModels[indexPath.row]
		return model.state != .disabled
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let model = cellModels[indexPath.row]
		if resetting {
			for model in cellModels where model.state == .selected {
				model.state = .closed
			}
			model.state = .selected
			activeCellIndex = indexPath.row
			resetting = false
		} else {
			if let index = activeCellIndex {
				if indexPath.row != index {
					if model.number == cellModels[index].number {
						model.state = .disabled
						self.cellModels[index].state = .disabled
						progress += 1
						activeCellIndex = nil
					} else {
						model.state = .selected
						resetting = true
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
							if self.resetting {
								model.state = .closed
								self.cellModels[index].state = .closed
								self.activeCellIndex = nil
								collectionView.reloadData()
								self.resetting = false
							}
						}
					}
				} else {
					return
				}
			} else {
				model.state = .selected
				activeCellIndex = indexPath.row
			}
		}
		tapsCount += 1
		collectionView.reloadData()
		if tapsCount == 1 {
			counter.invalidate()
			start = Date()
			counter = Timer.scheduledTimer(timeInterval: 1,
										   target: self,
										   selector: #selector(counterTick),
										   userInfo: nil,
										   repeats: true)
		}
		if progress > 7 {
			counter.invalidate()
		}
	}
	
	@objc func counterTick() {
		collectionView?.reloadData()
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let screenSize = UIScreen.main.bounds.size
		let minSide = min(screenSize.width, screenSize.height)
		let side = minSide/4 - 3
		return CGSize(width: side, height: side)
	}
	
}
