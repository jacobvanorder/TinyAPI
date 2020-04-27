import Foundation
struct Geocode : Codable {
	let statename : String?
	let distance : String?
	let elevation : String?
	let state : String?
	let latt : String?
	let city : String?
	let prov : String?
	let geocode : String?
	let geonumber : String?
	let country : String?
	let stnumber : String?
	let staddress : String?
	let inlatt : String?
	let alt : Alt?
	let timezone : String?
	let region : String?
	let postal : String?
	let longt : String?
	let confidence : String?
	let inlongt : String?
	let altgeocode : String?

	enum CodingKeys: String, CodingKey {
		case statename = "statename"
		case distance = "distance"
		case elevation = "elevation"
		case state = "state"
		case latt = "latt"
		case city = "city"
		case prov = "prov"
		case geocode = "geocode"
		case geonumber = "geonumber"
		case country = "country"
		case stnumber = "stnumber"
		case staddress = "staddress"
		case inlatt = "inlatt"
		case alt = "alt"
		case timezone = "timezone"
		case region = "region"
		case postal = "postal"
		case longt = "longt"
		case confidence = "confidence"
		case inlongt = "inlongt"
		case altgeocode = "altgeocode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		statename = try values.decodeIfPresent(String.self, forKey: .statename)
		distance = try values.decodeIfPresent(String.self, forKey: .distance)
		elevation = try values.decodeIfPresent(String.self, forKey: .elevation)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		latt = try values.decodeIfPresent(String.self, forKey: .latt)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		prov = try values.decodeIfPresent(String.self, forKey: .prov)
		geocode = try values.decodeIfPresent(String.self, forKey: .geocode)
		geonumber = try values.decodeIfPresent(String.self, forKey: .geonumber)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		stnumber = try values.decodeIfPresent(String.self, forKey: .stnumber)
		staddress = try values.decodeIfPresent(String.self, forKey: .staddress)
		inlatt = try values.decodeIfPresent(String.self, forKey: .inlatt)
		alt = try values.decodeIfPresent(Alt.self, forKey: .alt)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
		region = try values.decodeIfPresent(String.self, forKey: .region)
		postal = try values.decodeIfPresent(String.self, forKey: .postal)
		longt = try values.decodeIfPresent(String.self, forKey: .longt)
		confidence = try values.decodeIfPresent(String.self, forKey: .confidence)
		inlongt = try values.decodeIfPresent(String.self, forKey: .inlongt)
		altgeocode = try values.decodeIfPresent(String.self, forKey: .altgeocode)
	}
    
    enum GeocodeError: Error {
        case BadURL(Double, Double)
        case Network(Error?)
        case BadJSON(Error?)
    }
    
    static func fetch(lat: Double,
                      long: Double,
                      callback: @escaping (Result<Geocode, GeocodeError>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "geocode.xyz"
        components.path = "/\(lat),\(long)"
        components.queryItems = [URLQueryItem(name: "json", value: "1")]
        guard let url = components.url else {
            callback(.failure(.BadURL(lat, long)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            (optionalData, _, optionalError) in
            DispatchQueue.main.async {
                guard let data = optionalData else {
                    callback(.failure(.Network(optionalError)))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let geocode = try decoder.decode(Geocode.self, from: data)
                    callback(.success(geocode))
                } catch {
                    callback(.failure(.BadJSON(error)))
                    return
                }                
            }
        }
        task.resume()
    }
}
