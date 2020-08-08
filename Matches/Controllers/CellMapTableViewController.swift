//
//  CellMapTableViewController.swift
//  Matches
//
//  Created by Stanislav on 03.03.2020.
//  Copyright © 2020 SSE. All rights reserved.
//

import Foundation

/// The table for selecting cell map option.
class CellMapTableViewController: SelectionTableViewController {
	
	let timeFormatter = DurationFormatter()
    
    /// `SelectionTableViewController` setup goes here.
    /// Arranging cells: list of available environments, spacer cell and list of available schemes (https and http).
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Select Cell Map"
        let cellMaps = CellMap.allCases
		cells = cellMaps.map { ($0.title,
								"\(timeFormatter.string(from: Storage.highscores[$0]?.duration ?? 0)) / \(Storage.highscores[$0]?.tapsCount ?? 0)") }
        isCellSelectedAt = { row in
			// if row == cellMaps.firstIndex(of: Storage.selectedCellMap) {
            //    return true // defines selected cell map
            // }
            return false
        }
        selectionHandler = { [weak self] row in
            if cellMaps.indices.contains(row) {
                // select the cell map
                Storage.selectedCellMap = cellMaps[row]
				self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
