//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Andrey Androsov on 25.01.2023.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    private var cellID = "CellID"
    var habit: Habit!
    private var store = HabitsStore.shared
    
    private lazy var daysList: UITableView = {
        let daysList = UITableView()
        daysList.backgroundColor = .systemGray5
        daysList.dataSource = self
        daysList.delegate = self
        daysList.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        daysList.translatesAutoresizingMaskIntoConstraints = false
        return daysList
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(daysList)
        NSLayoutConstraint.activate([
            daysList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            daysList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            daysList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            daysList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = habit.name
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGray6
        let rightButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editBtn))
        navigationItem.rightBarButtonItem = rightButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func editBtn(sender:UIButton){
        let habitView = HabitViewController()
        habitView.habit = habit
        habitView.habitState = .edit
        let navController = UINavigationController(rootViewController: habitView)
        navController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.dates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let date = store.dates[store.dates.count - indexPath.row - 1]
        cell.textLabel?.text = store.trackDateString(forIndex: store.dates.count - indexPath.row - 1)
        if store.habit(habit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
