//
//  BaseViewController.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }

    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
}
