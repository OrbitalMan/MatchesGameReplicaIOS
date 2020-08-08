//
//  SessionRecord.swift
//  Matches
//
//  Created by Stanislav Shemiakov on 08.08.2020.
//  Copyright © 2020 SSE. All rights reserved.
//

import Foundation

struct SessionRecord: Codable {
	let duration: TimeInterval
	let tapsCount: Int
}
