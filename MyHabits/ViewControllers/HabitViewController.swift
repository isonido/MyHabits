//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Andrey Androsov on 12.01.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habit: Habit?
    private var store = HabitsStore.shared
    var habitState: HabitState = .create
    private var titleCurrent: String = "Бег"
    private var colorCurrent: UIColor = .systemOrange
    private var dateCurrent: Date = Date()
    private var picker = UIColorPickerViewController()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = titleHabit
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var nameHabitTf: UITextField = {
        let nameHabitTf = UITextField()
        nameHabitTf.textAlignment = .left
        nameHabitTf.font = UIFont.boldSystemFont(ofSize: 14)
        nameHabitTf.textColor = .systemBlue
        nameHabitTf.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        nameHabitTf.tintColor = .systemGray
        nameHabitTf.delegate = self
        nameHabitTf.translatesAutoresizingMaskIntoConstraints = false
        return nameHabitTf
    }()

    private var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = colorHabit
        colorLabel.font = UIFont.systemFont(ofSize: 13)
        colorLabel.textColor = .black
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorLabel
    }()
    
    private lazy var colorBtn: UIButton = {
        let colorBtn = UIButton()
        colorBtn.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        colorBtn.tintColor = colorCurrent
        colorBtn.addTarget(self, action: #selector(colorBtnPressed), for: .touchUpInside)
        colorBtn.translatesAutoresizingMaskIntoConstraints = false
        return colorBtn
    }()
    
    private var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = timeHabit
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private var datePickerLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton()
        deleteBtn.setTitle("Удалить привычку", for: .normal)
        deleteBtn.setTitleColor(.systemRed, for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteBtnPressed), for: .touchUpInside)
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        return deleteBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let habit{
            titleCurrent = habit.name
            colorCurrent = habit.color
            dateCurrent = habit.date
        }
        picker.delegate = self
        picker.selectedColor = colorCurrent
        setupViews()
        setupLayer()
    }
    
    private func setupViews() {
        if habitState == .create {
            navigationItem.title = "Создать"
            deleteBtn.isHidden = true
        } else {
            navigationItem.title = "Править"
            deleteBtn.isHidden = false
            nameHabitTf.text = titleCurrent
        }
        
        view.backgroundColor = .white
        let leftButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(leftButtonClick))
        navigationItem.leftBarButtonItem = leftButton
        let rightButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(rightButtonClick))
        navigationItem.rightBarButtonItem = rightButton
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(nameLabel)
        view.addSubview(nameHabitTf)
        view.addSubview(colorLabel)
        view.addSubview(colorBtn)
        view.addSubview(dateLabel)
        view.addSubview(datePickerLabel)
        view.addSubview(datePicker)
        view.addSubview(deleteBtn)
    }
    
    private func setupLayer() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameHabitTf.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameHabitTf.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameHabitTf.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            colorLabel.topAnchor.constraint(equalTo: nameHabitTf.bottomAnchor, constant: 16),
            colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            colorBtn.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            dateLabel.topAnchor.constraint(equalTo: colorBtn.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            datePickerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            datePickerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            deleteBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deleteBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deleteBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func leftButtonClick(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func rightButtonClick(sender:UIButton){
        if habitState == .create {
            store.habits.append(Habit(name: titleCurrent, date: dateCurrent, color: colorCurrent))
        } else {
            store.save()
        }
        dismiss(animated: true)
    }
    
    @objc func colorBtnPressed(sender:UIButton){
        present(picker, animated: true)
    }
    
    @objc func deleteBtnPressed(sender:UIButton){
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(habit!.name)\"?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive) { _ in
            self.store.habits.removeAll{
                $0 == self.habit
            }
            self.dismiss(animated: true)
        })
    }
    
    @objc func setDate(sender:UIDatePicker){
        dateCurrent = sender.date
        datePickerLabel.text = habit?.dateString
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        titleCurrent = textField.text ?? ""
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorCurrent = color
        colorBtn.tintColor = colorCurrent
    }
}
