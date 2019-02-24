//
//  AddHandlerViewController.swift
//  int20hProject
//
//  Created by Ivan Karpets on 2/24/19.
//  Copyright © 2019 Nikita Skrypchenko . All rights reserved.
//

import UIKit

class AddHandlerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(buttonAdd)
        
        buttonAdd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonAdd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonAdd.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonAdd.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    let buttonAdd:UIButton={
       var b = UIButton()
        b.titleLabel?.text = "Add" 
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    
    
  
}
