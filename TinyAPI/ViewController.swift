//
//  ViewController.swift
//  TinyAPI
//
//  Created by mrJacob on 4/27/20.
//  Copyright © 2020 SushiGrass. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private func fetchGeocode(lat: Double,
                              long: Double,
                              callback: @escaping (Result<Geocode, Geocode.GeocodeError>) -> Void) {
        Geocode.fetch(lat: lat, long: long) {
            [weak self]
            (result) in
            switch result {
            case .success(let geocode):
                self?.handle(geocode: geocode)
            case .failure(let error):
                self?.handle(geocodeError: error)
            }
        }
    }

    private func handle(geocode: Geocode) {
        NSLog("\(String(describing: geocode.city))")
    }
    
    private func handle(geocodeError: Geocode.GeocodeError) {
        NSLog(geocodeError.localizedDescription)
    }

}

