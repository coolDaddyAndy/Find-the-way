//
//  Alert.swift
//  Find the way
//
//  Created by Andrei Sushkou on 16.03.23.
//

import UIKit


extension UIViewController {
    
    func alertAddAdress(title: String, placeholder: String, complitionHndler: @escaping(String) ->Void) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default) { action in
            let tfText = alertController.textFields?.first
            guard let text = tfText?.text else {return}
            complitionHndler(text)
        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        alertController.addAction(okAlert)
        alertController.addAction(cancelAlert)
        present(alertController, animated: true)
    }
    
    func alertError(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(alertOk)
        present(alertController, animated: true)
    }
}
