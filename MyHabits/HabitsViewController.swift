//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Andrey Androsov on 11.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.isTranslucent = true
        //navigationController?.navigationBar.backgroundColor = .green
        navigationItem.title = "Сегодня"
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonClick))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func buttonClick(sender:UIButton){

    }

}
