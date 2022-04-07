//
//  CellProtocol.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 06.04.2022.
//

import Foundation

protocol CellConfiguration {
    
    associatedtype CellType: Any
    
    static var resuseId: String { get }
    func setCell(with object: CellType)
}
