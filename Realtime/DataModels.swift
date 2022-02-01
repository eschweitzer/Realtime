//
//  DataModels.swift
//  Realtime
//
//  Created by Eric Schweitzer on 1/31/22.
//

import Foundation

struct ResponseObj: Decodable {
    var sf: String?
    var lfs: [LongForm]
}

struct LongForm: Decodable {
    var lf: String?
    var freq: Int?
    var since: Int?
    var vars: [Variation]
}

struct Variation: Decodable {
    var lf: String?
    var freq: Int?
    var since: Int?
}
