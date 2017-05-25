//
//  MatchesCollectionViewController.swift
//  Matches
//
//  Created by Stanislav on 5/25/17.
//  Copyright © 2017 SSE. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MatchesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	var cellModels: [CellModel] = .random
	
	var activeCellIndex: Int? = nil
	
	var resetting: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		clearsSelectionOnViewWillAppear = false
	}
	
	// MARK: IBActions
	
	@IBAction func refresh(_ sender: UIBarButtonItem) {
		cellModels = .random
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
		cell.backgroundColor = model.color
		cell.titleLabel.text = model.number.rawValue
		cell.titleLabel.isHidden = model.titleIsHidden
		return cell
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
			collectionView.reloadData()
			resetting = false
		} else {
			if let index = activeCellIndex {
				if indexPath.row != index {
					if model.number == cellModels[index].number {
						model.state = .disabled
						self.cellModels[index].state = .disabled
						activeCellIndex = nil
						collectionView.reloadData()
					} else {
						model.state = .selected
						collectionView.reloadData()
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
				}
			} else {
				model.state = .selected
				activeCellIndex = indexPath.row
				collectionView.reloadData()
			}
		}
		
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let screenSize = UIScreen.main.bounds.size
		let minSide = min(screenSize.width, screenSize.height)
		let side = minSide/4 - 2
		return CGSize(width: side, height: side)
	}
	
}
