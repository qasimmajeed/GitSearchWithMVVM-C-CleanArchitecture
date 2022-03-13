//
//  UITableView+Extension.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

extension UITableView {
    /// This will dequeue the cell by given indexPath.
    /// - Parameters
    ///     - indexPath:  specify the indexPath for the cell.
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't dequeue with the given identifier\(T.reuseIdentifier)")
        }
        return cell
    }
}
