//
//  UIStoryboard+Extension.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

extension UIStoryboard {
    /// Define all the enums case for the storyboards
    enum Name: String {
        case GitRepository
    }
    
    convenience init(name: Name, bundle: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: bundle)
    }
}
