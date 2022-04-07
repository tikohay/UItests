//
//  File.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 06.04.2022.
//

import Foundation

struct UserData: Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Adress
    var phone: String
    var website: String
    var company: Company
}

struct Adress: Decodable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Location
}

struct Location: Decodable {
    var lat: String
    var lng: String
}

struct Company: Decodable {
    var name: String
    var catchPhrase: String
    var bs: String
}

