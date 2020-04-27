import Foundation
struct Location : Codable {
	let staddress : String?
	let stnumber : String?
	let postal : String?
	let latt : String?
	let city : String?
	let prov : String?
	let longt : String?

	enum CodingKeys: String, CodingKey {

		case staddress = "staddress"
		case stnumber = "stnumber"
		case postal = "postal"
		case latt = "latt"
		case city = "city"
		case prov = "prov"
		case longt = "longt"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		staddress = try values.decodeIfPresent(String.self, forKey: .staddress)
		stnumber = try values.decodeIfPresent(String.self, forKey: .stnumber)
		postal = try values.decodeIfPresent(String.self, forKey: .postal)
		latt = try values.decodeIfPresent(String.self, forKey: .latt)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		prov = try values.decodeIfPresent(String.self, forKey: .prov)
		longt = try values.decodeIfPresent(String.self, forKey: .longt)
	}

}
