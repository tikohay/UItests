//
//  UserPresenterProtocol.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 07.04.2022.
//

import Foundation

protocol UserPresenterProtocol {
    var users: [UserData] { get }
    init(view: UserInputView, networkService: NetworkService)
    func viewDidLoad()
}
