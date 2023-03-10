//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Andrey Androsov on 11.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    private var cellIdentifier = "CellIdentifier"
    private var headerIdentifier = "HeaderIdentifier"
    private var store = HabitsStore.shared
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
        let habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        habitsCollectionView.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 6, right: 16)
        habitsCollectionView.dataSource = self
        habitsCollectionView.delegate = self
        habitsCollectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        habitsCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        habitsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return habitsCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(habitsCollectionView)
        setupView()
        setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsCollectionView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = .systemGray6
        habitsCollectionView.backgroundColor = .systemGray5

        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationController() {
        navigationItem.title = "??????????????"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonClick))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func buttonClick(sender:UIButton){
        let habitView = HabitViewController()
        let navController = UINavigationController(rootViewController: habitView)
        navController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HabitCollectionViewCell
        cell.setupCell(habit: store.habits[indexPath.item])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderView
        header.setPogress()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HabitDetailsViewController()
        vc.habit = store.habits[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.habits.count
    }
}
