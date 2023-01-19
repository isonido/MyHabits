//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Andrey Androsov on 12.01.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = titleHabit
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private var nameHabitTf: UITextField = {
        let nameHabitTf = UITextField()
        nameHabitTf.textAlignment = .left
        //nameHabitTf.text = "Бегать по утрам, спать 8 часов и т.п."
        nameHabitTf.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameHabitTf.textColor = .gray
        nameHabitTf.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        nameHabitTf.translatesAutoresizingMaskIntoConstraints = false
        return nameHabitTf
    }()

    private var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = colorHabit
        colorLabel.font = UIFont.systemFont(ofSize: 14)
        colorLabel.textColor = .black
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayer()
    }
    
    private func setupViews() {
        navigationItem.title = "Сегодня"
        view.backgroundColor = .white
        let leftButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(leftButtonClick))
        navigationItem.leftBarButtonItem = leftButton
        let rightButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(rightButtonClick))
        navigationItem.rightBarButtonItem = rightButton
        
        view.addSubview(nameLabel)
        view.addSubview(nameHabitTf)
        view.addSubview(colorLabel)
    }
    
    private func setupLayer() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            nameHabitTf.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameHabitTf.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            colorLabel.topAnchor.constraint(equalTo: nameHabitTf.bottomAnchor, constant: 16),
            colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    @objc func leftButtonClick(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func rightButtonClick(sender:UIButton){
        
    }
}
