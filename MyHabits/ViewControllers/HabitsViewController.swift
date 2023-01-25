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
        //layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
        let habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    func setupView() {
        view.backgroundColor = .systemGray6
        habitsCollectionView.backgroundColor = .systemGray
        habitsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationController() {
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.isTranslucent = true
        //navigationController?.navigationBar.backgroundColor = .green
        
        
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.habits.count
    }
}
