//
//  UITableViewCell+Extension.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

/// Define to get the reuseIdentifier
protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    /// Will return the reuse identifier same a given class.
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifying {}
