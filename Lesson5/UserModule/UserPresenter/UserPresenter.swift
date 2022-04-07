//
//  Presenter.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 06.04.2022.
//

import Foundation

class UserPresenter: UserPresenterProtocol, UserOutputView {
    
    private let view: UserInputView
    private let networkService: NetworkService
    private let urlString = "https://jsonplaceholder.typicode.com/users"
    
    var users: [UserData] = []
    
    required init(view: UserInputView, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func getUsers(from urlString: String) {
        guard let data = networkService.getData(from: urlString) else { return }
        networkService.parseFrom(data: data, type: [UserData].self) { result in
            switch result {
            case let .success(users):
                self.users = users
                self.view.didGetUsers()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func viewDidLoad() {
        getUsers(from: urlString)
    }
}
