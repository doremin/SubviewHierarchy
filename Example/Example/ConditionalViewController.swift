//
//  ConditionalViewController.swift
//  Example
//
//  Created by doremin on 6/10/25.
//

import UIKit
import SubviewHierarchy

final class ConditionalViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "I'm a UILabel 🎉"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let shouldShow = true

        // MARK: - DSL UI
        let container = UIView() {
            if shouldShow {
                label
            } else {
                imageView
            }
        }

        container.translatesAutoresizingMaskIntoConstraints = false
        view {
            container
        }
        
        guard let subview = container.subviews.first else {
            return
        }

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 240),
            container.heightAnchor.constraint(equalToConstant: 100),
            
            subview.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            subview.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            subview.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6)
        ])

        // MARK: - 코드 문자열
        let codeString = """
        let shouldShow = true

        let container = UIView() {
            if shouldShow {
                label
            } else {
                imageView
            }
        }
        """

        let codeView = makeHighlightedCodeView(code: codeString)

        view {
            codeView
        }

        NSLayoutConstraint.activate([
            codeView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 24),
            codeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            codeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func makeHighlightedCodeView(code: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.systemGray6
        container.layer.cornerRadius = 12
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemGray4.cgColor

        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        let attributed = NSMutableAttributedString(string: code)
        let fullRange = NSRange(location: 0, length: attributed.length)

        let keywordAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.monospacedSystemFont(ofSize: 14, weight: .semibold)
        ]
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        ]

        attributed.addAttributes(defaultAttributes, range: fullRange)

        let keywords = ["let", "if", "else", "UIView", "UILabel", "UIImageView", "shouldShow", "container"]
        for keyword in keywords {
            let pattern = "\\b\(keyword)\\b"
            let regex = try! NSRegularExpression(pattern: pattern)
            for match in regex.matches(in: code, range: fullRange) {
                attributed.addAttributes(keywordAttributes, range: match.range)
            }
        }

        textView.attributedText = attributed

        container.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: container.topAnchor),
            textView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])

        return container
    }
}
