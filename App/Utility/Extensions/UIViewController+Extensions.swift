//
//  UIViewController+Extensions.swift
//  Victor Catao
//
//  Created by Victor Catao on 18/12/2017.
//  Copyright © 2017 Victor Catao. All rights reserved.
//

import UIKit

private var loaderView: UIView?

extension UIViewController {
    
    /// Shows an alert with custom title, message and actions
    func showSuccessAlert(message: String, completion: @escaping ()->Void) {
        self.showAlert(title: "Sucesso", message: message, okBlock: completion)
    }
    
    func showErrorAlert(message: String) {
        self.showAlert(title: "Erro!", message: message)
    }
    
    func showAlert(title: String, message: String, okBlock:(() -> Void)?=nil, cancelBlock: (() -> Void)?=nil){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var titleOkAction     = "Ok"
        var titleCancelAction = "Cancelar"
        
        if (cancelBlock != nil) {
            titleOkAction     = "Sim"
            titleCancelAction = "Não"
        }
        
        let ok = UIAlertAction(title: titleOkAction, style: .default) { (action) in
            if let okBl = okBlock {
                okBl()
            }
            alert.dismiss(animated: true, completion: nil);
        }
        alert.addAction(ok)
        
        if let cancelBl = cancelBlock {
            let cancel = UIAlertAction(title: titleCancelAction, style: .cancel) { (action) in
                cancelBl()
            }
            alert.addAction(cancel)
        }
        self.present(alert, animated: true, completion: nil)
    }

    /// Shows a loading view over the current ViewController
    func showLoader() {
        
        if(loaderView == nil) {
            // creating loaderView
            loaderView = UIView(frame: UIScreen.main.bounds)
            loaderView!.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            
            // white view in center
            let centerView = CustomUIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            centerView.backgroundColor = .white
            centerView.cornerRadius = 4
            centerView.alpha = 0.5
            
            loaderView!.addSubview(centerView)
            centerView.center = loaderView!.center
            
            // stackview for loader and text
            let stackView = UIStackView(frame: centerView.frame)
            stackView.spacing = 8
            stackView.axis = .vertical
            
            // loader
            let loader = UIActivityIndicatorView(style: .gray)
            loader.startAnimating()
            stackView.addArrangedSubview(loader)
            
            // add stackview as subview for centerView
            centerView.addSubview(stackView)
            
            // setup constraints
            stackView.translatesAutoresizingMaskIntoConstraints = false
            centerView.addConstraints([
                NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: centerView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: centerView, attribute: .trailing, multiplier: 1, constant: 0)
            ])
            
        }
        
        if self.navigationController ==  nil {
            self.view.addSubview(loaderView!)
        } else {
            self.navigationController?.view.addSubview(loaderView!)
        }
        
    }
    
    /// Hides the loading view which is over the current ViewController
    func hideLoader () {
        if(loaderView != nil){
            loaderView?.removeFromSuperview()
        }
    }

    /// Blocks the user's interactions with the view
    func lockView(_ view: UIView){
        view.isUserInteractionEnabled = false
    }
    
    /// Enables the user's interactions with the view
    func unlockView(_ view: UIView) {
        view.isUserInteractionEnabled = true
    }
    
}
