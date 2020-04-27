//
//  ViewController.swift
//  TinyAPI
//
//  Created by mrJacob on 4/27/20.
//  Copyright © 2020 SushiGrass. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var latitudeTextField: UITextField!
    @IBOutlet var longitudeTextField: UITextField!
    @IBOutlet var streetResultLabel: UILabel!
    @IBOutlet var cityResultLabel: UILabel!
    @IBOutlet var stateResultLabel: UILabel!
    @IBOutlet var zipResult: UILabel!
    
    @IBOutlet var fetchButton: UIButton!
    
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        streetResultLabel.text = .none
        cityResultLabel.text = .none
        stateResultLabel.text = .none
        zipResult.text = .none
        guard
            let latText = latitudeTextField.text,
            let lat = Double(latText),
            let longText = longitudeTextField.text,
            let long = Double(longText) else { return }
        fetchButton.isEnabled = false
        Geocode.fetch(lat: lat,
                     long: long) {
                        [weak self]
                        (result) in
                        defer { self?.fetchButton.isEnabled = true }
                        switch result {
                        case .success(let geocode):
                            self?.handle(geocode: geocode)
                        case .failure(let error):
                            self?.handle(geocodeError: error)
                        }
        }
    }

    private func handle(geocode: Geocode) {
        streetResultLabel.text = "\(geocode.stnumber ?? "") \(geocode.staddress ?? "")"
        cityResultLabel.text = geocode.city
        stateResultLabel.text = geocode.state
        zipResult.text = geocode.postal
    }
    
    private func handle(geocodeError: Geocode.GeocodeError) {
        NSLog(geocodeError.localizedDescription)
    }

}

