//
//  CellMaps.swift
//  Matches
//
//  Created by Stanislav on 03.03.2020.
//  Copyright © 2020 SSE. All rights reserved.
//

import Foundation

enum CellMap: Int, Codable, CaseIterable {
	
	case number
	
	case hiraganaVowels
	case hiraganaK
	case hiraganaS
	case hiraganaT
	case hiraganaN
	case hiraganaH
	case hiraganaM
	case hiraganaR
	case hiraganaG
	case hiraganaZ
	case hiraganaD
	case hiraganaB
	case hiraganaP
	case hiraganaOther
	
	case katakanaVowels
	case katakanaK
	case katakanaS
	case katakanaT
	case katakanaN
	case katakanaH
	case katakanaM
	case katakanaR
	case katakanaG
	case katakanaZ
	case katakanaD
	case katakanaB
	case katakanaP
	case katakanaOther
	
	var title: String {
		switch self {
		case .number: return "Numbers"
			
		case .hiraganaVowels: return "Hiragana: Vowels"
		case .hiraganaK: return "Hiragana: K"
		case .hiraganaS: return "Hiragana: S"
		case .hiraganaT: return "Hiragana: T"
		case .hiraganaN: return "Hiragana: N"
		case .hiraganaH: return "Hiragana: H"
		case .hiraganaM: return "Hiragana: M"
		case .hiraganaR: return "Hiragana: R"
		case .hiraganaG: return "Hiragana: G"
		case .hiraganaZ: return "Hiragana: Z"
		case .hiraganaD: return "Hiragana: D"
		case .hiraganaB: return "Hiragana: B"
		case .hiraganaP: return "Hiragana: P"
		case .hiraganaOther: return "Hiragana: Other"
			
		case .katakanaVowels: return "Katakana: Vowels"
		case .katakanaK: return "Katakana: K"
		case .katakanaS: return "Katakana: S"
		case .katakanaT: return "Katakana: T"
		case .katakanaN: return "Katakana: N"
		case .katakanaH: return "Katakana: H"
		case .katakanaM: return "Katakana: M"
		case .katakanaR: return "Katakana: R"
		case .katakanaG: return "Katakana: G"
		case .katakanaZ: return "Katakana: Z"
		case .katakanaD: return "Katakana: D"
		case .katakanaB: return "Katakana: B"
		case .katakanaP: return "Katakana: P"
		case .katakanaOther: return "Katakana: Other"
		}
	}
	
	var models: [CellModel] {
		switch self {
		case .number: return CellModelGenerator<CellNumber>.randomModels
			
		case .hiraganaVowels: return CellModelGenerator<HiraganaMap<JapanVowels>>.randomModels
		case .hiraganaK: return CellModelGenerator<HiraganaMap<JapanK>>.randomModels
		case .hiraganaS: return CellModelGenerator<HiraganaMap<JapanS>>.randomModels
		case .hiraganaT: return CellModelGenerator<HiraganaMap<JapanT>>.randomModels
		case .hiraganaN: return CellModelGenerator<HiraganaMap<JapanN>>.randomModels
		case .hiraganaH: return CellModelGenerator<HiraganaMap<JapanH>>.randomModels
		case .hiraganaM: return CellModelGenerator<HiraganaMap<JapanM>>.randomModels
		case .hiraganaR: return CellModelGenerator<HiraganaMap<JapanR>>.randomModels
		case .hiraganaG: return CellModelGenerator<HiraganaMap<JapanG>>.randomModels
		case .hiraganaZ: return CellModelGenerator<HiraganaMap<JapanZ>>.randomModels
		case .hiraganaD: return CellModelGenerator<HiraganaMap<JapanD>>.randomModels
		case .hiraganaB: return CellModelGenerator<HiraganaMap<JapanB>>.randomModels
		case .hiraganaP: return CellModelGenerator<HiraganaMap<JapanP>>.randomModels
		case .hiraganaOther: return CellModelGenerator<HiraganaMap<JapanOther>>.randomModels
			
		case .katakanaVowels: return CellModelGenerator<KatakanaMap<JapanVowels>>.randomModels
		case .katakanaK: return CellModelGenerator<KatakanaMap<JapanK>>.randomModels
		case .katakanaS: return CellModelGenerator<KatakanaMap<JapanS>>.randomModels
		case .katakanaT: return CellModelGenerator<KatakanaMap<JapanT>>.randomModels
		case .katakanaN: return CellModelGenerator<KatakanaMap<JapanN>>.randomModels
		case .katakanaH: return CellModelGenerator<KatakanaMap<JapanH>>.randomModels
		case .katakanaM: return CellModelGenerator<KatakanaMap<JapanM>>.randomModels
		case .katakanaR: return CellModelGenerator<KatakanaMap<JapanR>>.randomModels
		case .katakanaG: return CellModelGenerator<KatakanaMap<JapanG>>.randomModels
		case .katakanaZ: return CellModelGenerator<KatakanaMap<JapanZ>>.randomModels
		case .katakanaD: return CellModelGenerator<KatakanaMap<JapanD>>.randomModels
		case .katakanaB: return CellModelGenerator<KatakanaMap<JapanB>>.randomModels
		case .katakanaP: return CellModelGenerator<KatakanaMap<JapanP>>.randomModels
		case .katakanaOther: return CellModelGenerator<KatakanaMap<JapanOther>>.randomModels
		}
	}
	
}

enum CellNumber: Int, CaseIterable, CellInfo {
	case one
	case two
	case three
	case four
	case five
	case six
	case seven
	case eight
	
	var titleFront: String {
		return String(rawValue+1)
	}
	
	var titleBack: String {
		return String(rawValue+1)
	}
	
}

protocol JapaneseSyllable: Equatable, CaseIterable {
	var hiragana: String { get }
	var katakana: String { get }
	var hepburn: String { get }
}

struct HiraganaMap<Syllable: JapaneseSyllable>: CellInfo {
	
	let syllable: Syllable
	
	var titleFront: String {
		return syllable.hiragana
	}
	
	var titleBack: String {
		return syllable.hepburn
	}
	
	static var allCases: [HiraganaMap<Syllable>] {
		return Syllable.allCases.map { HiraganaMap<Syllable>(syllable: $0) }
	}
	
}

struct KatakanaMap<Syllable: JapaneseSyllable>: CellInfo {
	
	let syllable: Syllable
	
	var titleFront: String {
		return syllable.katakana
	}
	
	var titleBack: String {
		return syllable.hepburn
	}
	
	static var allCases: [KatakanaMap<Syllable>] {
		return Syllable.allCases.map { KatakanaMap<Syllable>(syllable: $0) }
	}
	
}

enum JapanVowels: JapaneseSyllable {
	case a
	case i
	case u
	case e
	case o
	case ya
	case yu
	case yo
	
	var hiragana: String {
		switch self {
		case .a: return "あ"
		case .i: return "い"
		case .u: return "う"
		case .e: return "え"
		case .o: return "お"
		case .ya: return "や"
		case .yu: return "ゆ"
		case .yo: return "よ"
		}
	}
	
	var katakana: String {
		switch self {
		case .a: return "ア"
		case .i: return "イ"
		case .u: return "ウ"
		case .e: return "エ"
		case .o: return "オ"
		case .ya: return "ヤ"
		case .yu: return "ユ"
		case .yo: return "ヨ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanK: JapaneseSyllable {
	case ka
	case ki
	case ku
	case ke
	case ko
	case kya
	case kyu
	case kyo
	
	var hiragana: String {
		switch self {
		case .ka: return "か"
		case .ki: return "き"
		case .ku: return "く"
		case .ke: return "け"
		case .ko: return "こ"
		case .kya: return "きゃ"
		case .kyu: return "きゅ"
		case .kyo: return "きょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .ka: return "カ"
		case .ki: return "キ"
		case .ku: return "ク"
		case .ke: return "ケ"
		case .ko: return "コ"
		case .kya: return "キャ"
		case .kyu: return "キュ"
		case .kyo: return "キョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanS: JapaneseSyllable {
	case sa
	case shi
	case su
	case se
	case so
	case sha
	case shu
	case sho
	
	var hiragana: String {
		switch self {
		case .sa: return "さ"
		case .shi: return "し"
		case .su: return "す"
		case .se: return "せ"
		case .so: return "そ"
		case .sha: return "しゃ"
		case .shu: return "しゅ"
		case .sho: return "しょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .sa: return "サ"
		case .shi: return "シ"
		case .su: return "ス"
		case .se: return "セ"
		case .so: return "ソ"
		case .sha: return "シャ"
		case .shu: return "シュ"
		case .sho: return "ショ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanT: JapaneseSyllable {
	case ta
	case chi
	case tsu
	case te
	case to
	case cha
	case chu
	case cho
	
	var hiragana: String {
		switch self {
		case .ta: return "た"
		case .chi: return "ち"
		case .tsu: return "つ"
		case .te: return "て"
		case .to: return "と"
		case .cha: return "ちゃ"
		case .chu: return "ちゅ"
		case .cho: return "ちょ"
			
		}
	}
	
	var katakana: String {
		switch self {
		case .ta: return "タ"
		case .chi: return "チ"
		case .tsu: return "ツ"
		case .te: return "テ"
		case .to: return "ト"
		case .cha: return "チャ"
		case .chu: return "チュ"
		case .cho: return "チョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanN: JapaneseSyllable {
	case na
	case ni
	case nu
	case ne
	case no
	case nya
	case nyu
	case nyo
	
	var hiragana: String {
		switch self {
		case .na: return "な"
		case .ni: return "に"
		case .nu: return "ぬ"
		case .ne: return "ね"
		case .no: return "の"
		case .nya: return "にゃ"
		case .nyu: return "にゅ"
		case .nyo: return "にょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .na: return "ナ"
		case .ni: return "ニ"
		case .nu: return "ヌ"
		case .ne: return "ネ"
		case .no: return "ノ"
		case .nya: return "ニャ"
		case .nyu: return "ニュ"
		case .nyo: return "ニョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanH: JapaneseSyllable {
	case ha
	case hi
	case fu
	case he
	case ho
	case hya
	case hyu
	case hyo
	
	var hiragana: String {
		switch self {
		case .ha: return "は"
		case .hi: return "ひ"
		case .fu: return "ふ"
		case .he: return "へ"
		case .ho: return "ほ"
		case .hya: return "ひゃ"
		case .hyu: return "ひゅ"
		case .hyo: return "ひょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .ha: return "ハ"
		case .hi: return "ヒ"
		case .fu: return "フ"
		case .he: return "ヘ"
		case .ho: return "ホ"
		case .hya: return "ヒャ"
		case .hyu: return "ヒュ"
		case .hyo: return "ヒョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanM: JapaneseSyllable {
	case ma
	case mi
	case mu
	case me
	case mo
	case mya
	case myu
	case myo
	
	var hiragana: String {
		switch self {
		case .ma: return "ま"
		case .mi: return "み"
		case .mu: return "む"
		case .me: return "め"
		case .mo: return "も"
		case .mya: return "みゃ"
		case .myu: return "みゅ"
		case .myo: return "みょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .ma: return "マ"
		case .mi: return "ミ"
		case .mu: return "ム"
		case .me: return "メ"
		case .mo: return "モ"
		case .mya: return "ミャ"
		case .myu: return "ミュ"
		case .myo: return "ミョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanR: JapaneseSyllable {
	case ra
	case ri
	case ru
	case re
	case ro
	case rya
	case ryu
	case ryo
	
	var hiragana: String {
		switch self {
		case .ra: return "ら"
		case .ri: return "り"
		case .ru: return "る"
		case .re: return "れ"
		case .ro: return "ろ"
		case .rya: return "りゃ"
		case .ryu: return "りゅ"
		case .ryo: return "りょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .ra: return "ラ"
		case .ri: return "リ"
		case .ru: return "ル"
		case .re: return "レ"
		case .ro: return "ロ"
		case .rya: return "リャ"
		case .ryu: return "リュ"
		case .ryo: return "リョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanG: JapaneseSyllable {
	case ga
	case gi
	case gu
	case ge
	case go
	case gya
	case gyu
	case gyo
	
	var hiragana: String {
		switch self {
		case .ga: return "が"
		case .gi: return "ぎ"
		case .gu: return "ぐ"
		case .ge: return "げ"
		case .go: return "ご"
		case .gya: return "ぎゃ"
		case .gyu: return "ぎゅ"
		case .gyo: return "ぎょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .ga: return "ガ"
		case .gi: return "ギ"
		case .gu: return "グ"
		case .ge: return "ゲ"
		case .go: return "ゴ"
		case .gya: return "ギャ"
		case .gyu: return "ギュ"
		case .gyo: return "ギョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanZ: JapaneseSyllable {
	case za
	case ji
	case zu
	case ze
	case zo
	case ja
	case ju
	case jo
	
	var hiragana: String {
		switch self {
		case .za: return "ざ"
		case .ji: return "じ"
		case .zu: return "ず"
		case .ze: return "ぜ"
		case .zo: return "ぞ"
		case .ja: return "じゃ"
		case .ju: return "じゅ"
		case .jo: return "じょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .za: return "ザ"
		case .ji: return "ジ"
		case .zu: return "ズ"
		case .ze: return "ゼ"
		case .zo: return "ゾ"
		case .ja: return "ジャ"
		case .ju: return "ジュ"
		case .jo: return "ジョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanD: JapaneseSyllable {
	case da
	case ji
	case zu
	case de
	case `do`
	case ja
	case ju
	case jo
	
	var hiragana: String {
		switch self {
		case .da: return "だ"
		case .ji: return "ぢ"
		case .zu: return "づ"
		case .de: return "で"
		case .do: return "ど"
		case .ja: return "ぢゃ"
		case .ju: return "ぢゅ"
		case .jo: return "ぢょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .da: return "ダ"
		case .ji: return "ヂ"
		case .zu: return "ヅ"
		case .de: return "デ"
		case .do: return "ド"
		case .ja: return "ジャ"
		case .ju: return "ジュ"
		case .jo: return "ジョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanB: JapaneseSyllable {
	case ba
	case bi
	case bu
	case be
	case bo
	case bya
	case byu
	case byo
	
	var hiragana: String {
		switch self {
		case .ba: return "ば"
		case .bi: return "び"
		case .bu: return "ぶ"
		case .be: return "べ"
		case .bo: return "ぼ"
		case .bya: return "びゃ"
		case .byu: return "びゅ"
		case .byo: return "びょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .ba: return "バ"
		case .bi: return "ビ"
		case .bu: return "ブ"
		case .be: return "ベ"
		case .bo: return "ボ"
		case .bya: return "ビャ"
		case .byu: return "ビュ"
		case .byo: return "ビョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanP: JapaneseSyllable {
	case pa
	case pi
	case pu
	case pe
	case po
	case pya
	case pyu
	case pyo
	
	var hiragana: String {
		switch self {
		case .pa: return "ぱ"
		case .pi: return "ぴ"
		case .pu: return "ぷ"
		case .pe: return "ぺ"
		case .po: return "ぽ"
		case .pya: return "ぴゃ"
		case .pyu: return "ぴゅ"
		case .pyo: return "ぴょ"
		}
	}
	
	var katakana: String {
		switch self {
		case .pa: return "パ"
		case .pi: return "ピ"
		case .pu: return "プ"
		case .pe: return "ペ"
		case .po: return "ポ"
		case .pya: return "ピャ"
		case .pyu: return "ピュ"
		case .pyo: return "ピョ"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

enum JapanOther: JapaneseSyllable {
	case wa
	case wo
	case n
	
	var hiragana: String {
		switch self {
		case .wa: return "わ"
		case .wo: return "を"
		case .n: return "ん"
		}
	}
	
	var katakana: String {
		switch self {
		case .wa: return "ワ"
		case .wo: return "ヲ"
		case .n: return "ン"
		}
	}
	
	var hepburn: String {
		return "\(self)"
	}
	
}

