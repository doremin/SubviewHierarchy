//
//  BasicViewController.swift
//  Example
//
//  Created by doremin on 6/10/25.
//

import UIKit

import SubviewHierarchy

final class BasicViewController: UIViewController {
    
    let box1 = UIView()
    let box2 = UIView()
    let box3 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let previewContainer = UIView() {
            box1 {
                box2
                box3
            }
        }
        
        box1.backgroundColor = .systemBlue
        box2.backgroundColor = .white
        box3.backgroundColor = .systemRed
        
        [box1, box2, box3].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
        }
        
        previewContainer.translatesAutoresizingMaskIntoConstraints = false
        view {
            previewContainer
        }
        
        NSLayoutConstraint.activate([
            previewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            previewContainer.widthAnchor.constraint(equalToConstant: 250),
            previewContainer.heightAnchor.constraint(equalToConstant: 250),
            
            box1.topAnchor.constraint(equalTo: previewContainer.topAnchor),
            box1.leadingAnchor.constraint(equalTo: previewContainer.leadingAnchor),
            box1.trailingAnchor.constraint(equalTo: previewContainer.trailingAnchor),
            box1.bottomAnchor.constraint(equalTo: previewContainer.bottomAnchor),
            
            box2.topAnchor.constraint(equalTo: box1.topAnchor, constant: 16),
            box2.leadingAnchor.constraint(equalTo: box1.leadingAnchor, constant: 16),
            box2.widthAnchor.constraint(equalToConstant: 80),
            box2.heightAnchor.constraint(equalToConstant: 80),
            
            box3.bottomAnchor.constraint(equalTo: box1.bottomAnchor, constant: -16),
            box3.trailingAnchor.constraint(equalTo: box1.trailingAnchor, constant: -16),
            box3.widthAnchor.constraint(equalToConstant: 80),
            box3.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        // MARK: - 코드 문자열
        let codeString = """
            view {
                box1 {
                    box2
                    box3
                }
            }
            """
        
        
        let codeView = makeHighlightedCodeView(code: codeString)
        view {
            codeView
        }
        
        NSLayoutConstraint.activate([
            codeView.topAnchor.constraint(equalTo: previewContainer.bottomAnchor, constant: 24),
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

        // TextView: 스크롤 가능하고 자동 줄바꿈
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

        // 코드 하이라이팅 적용
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

        let keywords = ["view", "box1", "box2", "box3"]
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
