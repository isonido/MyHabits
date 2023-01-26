//
//  HeaderView.swift
//  MyHabits
//
//  Created by Andrey Androsov on 19.01.2023.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    private var store = HabitsStore.shared
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Всё получится!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textColor = .systemGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var progressCountLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 13)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        addSubview(titleLabel)
        addSubview(progressView)
        addSubview(progressCountLabel)
        setupHeaderView()
        //setupCell()
    }
    
    func setupHeaderView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            progressCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            progressCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    func setPogress() {
        progressCountLabel.text = String(format: "%.0f %%", store.todayProgress * 100)
        progressView.progress = store.todayProgress
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
