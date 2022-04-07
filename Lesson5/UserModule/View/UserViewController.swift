//
//  ViewController.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 06.04.2022.
//

import UIKit

class UserViewController: UIViewController {
    
    var users: [UserData] = []
    let networkService = NetworkService()
    var data: Data?
    
    var presenter: (UserPresenterProtocol & UserOutputView)?
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.resuseId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
}

// MARK: - Setup views
private extension UserViewController {
    func setupViews() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.frame = view.bounds
    }
}

//MARK: - Setup DataSource, Delegate
extension UserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.users.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.resuseId, for: indexPath)
        guard let userCell = cell as? UserCell else { return cell }
        
        guard let user = presenter?.users[indexPath.row] else { return cell }
        userCell.setCell(with: user)
        userCell.backgroundColor = .systemPink
        
        return userCell
    }
}

extension UserViewController: UICollectionViewDelegate {
    
}

extension UserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height:150)
    }
}

extension UserViewController: UserInputView {
    func didGetUsers() {
        collectionView.reloadData()
    }
}
