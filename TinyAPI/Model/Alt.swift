import Foundation
struct Alt : Codable {
	let loc : [Location]?

	enum CodingKeys: String, CodingKey {
		case loc = "loc"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		loc = try values.decodeIfPresent([Location].self, forKey: .loc)
	}

}
