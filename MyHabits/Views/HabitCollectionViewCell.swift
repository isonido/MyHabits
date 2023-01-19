//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Andrey Androsov on 19.01.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private var habit = HabitsStore.shared.habits
    private let firstStateImg = UIImage(systemName: "checkmark.circle.fill")
    private let secondStateImg = UIImage(systemName: "circle")
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = textLabel
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = textLabel
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .black
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private var counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.text = textLabel
        counterLabel.font = UIFont.systemFont(ofSize: 12)
        counterLabel.textColor = .black
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        return counterLabel
    }()
    
    private lazy var statusBtn: UIButton = {
        let statusBtn = UIButton()
        statusBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusBtn.translatesAutoresizingMaskIntoConstraints = false
        return statusBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(statusBtn)
        setupCellView()
        //setupCell()
    }
    
    func setupCellView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            counterLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            statusBtn.widthAnchor.constraint(equalToConstant: 38),
            statusBtn.heightAnchor.constraint(equalToConstant: 38),
            statusBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
    
    func setupCell(habit: Habit) {
        titleLabel.text = habit.name
        titleLabel.textColor = habit.color
        descriptionLabel.text = habit.dateString
        counterLabel.text = "Подряд: \(habit.trackDates.count)"
        
        if habit.isAlreadyTakenToday{
            statusBtn.setImage(firstStateImg, for: .normal)
        } else {
            statusBtn.setImage(secondStateImg, for: .normal)
        }
        statusBtn.tintColor = habit.color
    }
    
    @objc func buttonPressed(sender:UIButton){
        if HabitsStore.shared.habits[IndexPath].isAlreadyTakenToday
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}