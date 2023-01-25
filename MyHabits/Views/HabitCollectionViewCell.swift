//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Andrey Androsov on 19.01.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private var store = HabitsStore.shared
    private let firstStateImg = UIImage(systemName: "checkmark.circle.fill")
    private let secondStateImg = UIImage(systemName: "circle")
    var index = 0
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .systemGray2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private var counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.font = UIFont.boldSystemFont(ofSize: 13)
        counterLabel.textColor = .systemGray
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
    }
    
    func setupCellView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
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
        counterLabel.text = "Счётчик: \(habit.trackDates.count)"
        
        if habit.isAlreadyTakenToday{
            statusBtn.setImage(firstStateImg, for: .normal)
        } else {
            statusBtn.setImage(secondStateImg, for: .normal)
        }
        statusBtn.tintColor = habit.color
        statusBtn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 38), forImageIn: .normal)
    }
    
    @objc func buttonPressed(sender:UIButton){
        if !store.habits[index].isAlreadyTakenToday{
            statusBtn.setImage(firstStateImg, for: .normal)
            store.track(store.habits[index])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
