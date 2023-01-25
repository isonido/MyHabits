//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Andrey Androsov on 11.01.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var textFieldContainer: UIView = {
        let textFieldContainer = UIView()
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        return textFieldContainer
    }()
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = textLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = textField
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.textContainer.lineFragmentPadding = 0
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
    }

    private func setupViews() {
        navigationItem.title = "Информация"
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(textFieldContainer)
        textFieldContainer.addSubview(titleLabel)
        textFieldContainer.addSubview(textView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textFieldContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textFieldContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textFieldContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textFieldContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 16),
            
            textView.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 62),
            textView.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor)
        ])
    }
}
