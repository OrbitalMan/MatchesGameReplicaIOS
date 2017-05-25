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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		clearsSelectionOnViewWillAppear = false
		self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
	}
	
	// MARK: IBActions
	
	@IBAction func refresh(_ sender: UIBarButtonItem) {
		print("refresh")
	}
	
	// MARK: UICollectionViewDataSource
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 16
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		cell.backgroundColor = .orange
		return cell
	}
	
	// MARK: UICollectionViewDelegate
	override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("item \(indexPath.row)")
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let screenSize = UIScreen.main.bounds.size
		let minSide = min(screenSize.width, screenSize.height)
		let side = minSide/4 - 2
		return CGSize(width: side, height: side)
	}
	
}
