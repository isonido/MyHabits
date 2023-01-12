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
        titleLabel.font = UIFont.systemFont(ofSize: 18)
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
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
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
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(textFieldContainer)
        textFieldContainer.addSubview(titleLabel)
        textFieldContainer.addSubview(textView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textFieldContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textFieldContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textFieldContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textFieldContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor)
        ])
    }
}
