//
//  HomeViewController.swift
//  Example
//
//  Created by doremin on 6/10/25.
//

import UIKit

import SubviewHierarchy

final class HomeViewController: UIViewController {
    
    private enum Destination: CaseIterable {
        case basic
        case conditional
        case array
        
        var title: String {
            switch self {
            case .basic:
                "Basic"
            case .conditional:
                "Conditional"
            case .array:
                "Array"
            }
        }
    }
    
    private enum Section {
        case main
    }
    
    private struct Item: Hashable {
        let title: String
        let destination: Destination
    }
    
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    private let items = Destination.allCases.map { destination in
        return Item(title: destination.title, destination: destination)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        declareSubview()
        configureTableView()
    }
    
    private func declareSubview() {
        view {
            tableView
        }
        
        
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: HomeViewCell.reuseIdentifier)
        tableView.delegate = self
        
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier -> UITableViewCell? in
            
            guard
                let self,
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.reuseIdentifier) as? HomeViewCell
            else {
                return nil
            }
            
            cell.configure(title: self.items[indexPath.row].title)
            
            return cell
        }
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var destination: UIViewController
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch items[indexPath.row].destination {
        case .basic:
            destination = BasicViewController()
        case .array:
            destination = ArrayViewController()
        case .conditional:
            destination = ConditionalViewController()
        }
        
        navigationController?.pushViewController(destination, animated: true)
    }
}
