//
//  ArrayViewController.swift
//  Example
//
//  Created by doremin on 6/10/25.
//

import UIKit
import SubviewHierarchy

final class ArrayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // MARK: - DSL 뷰 구성
        let buttons = (0..<3).map { i in
            let button = UIButton(type: .system)
            button.setTitle("Button \(i)", for: .normal)
            button.backgroundColor = .systemTeal
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            return button
        }

        let container = UIView() {
            buttons
        }
        
        container.translatesAutoresizingMaskIntoConstraints = false
        view {
            container
        }

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.widthAnchor.constraint(equalToConstant: 200),
            container.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        // 버튼 레이아웃 (수직 정렬)
        for (index, button) in buttons.enumerated() {
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
                button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
                button.heightAnchor.constraint(equalToConstant: 44)
            ])
            if index == 0 {
                button.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: buttons[index - 1].bottomAnchor, constant: 12).isActive = true
            }
        }

        // MARK: - 코드 문자열 표시
        let codeString = """
        let buttons = (0..<3).map { _ in UIButton() }

        let container = UIView() {
            buttons
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

        let keywords = ["UIView", "buttons", "container"]
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
