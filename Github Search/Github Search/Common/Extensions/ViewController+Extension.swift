//
//  ViewController+Extension.swift
//  Github Search
//
//  Created by Qasim Majeed on 27.02.22.
//

import UIKit

extension UIViewController {
    /// This display the alert with given message `.
    /// - Parameters
    ///     - message:  Use to provide the message for alert.
    func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// This methods will use to get the storyboardID same as controller name.
    static func storyboardID() -> String {
        return String(describing: self)
    }
}
