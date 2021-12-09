//
//  ExchangerResultViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation
import UIKit

class ExchangerResultViewController: UIViewController {
  // MARK: - Properties

  static let cellID = "exchangeTableCell"

  // MARK: - UI

  let dimmedView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
    return view
  }()

  let bottomSheetView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.roundCorners(cornerRadius: 25, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    return view
  }()

  let bottomSheetTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorColor = .white
    tableView.register(ExchangeResultTableCell.classForCoder(), forCellReuseIdentifier: cellID)
    tableView.allowsSelection = true
    return tableView
  }()
  let label: UILabel = {
    let label = UILabel()
    label.text = "test"
    return label
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    layout()
  }
  // MARK: - Layout
  func setView() {
    view.backgroundColor = .orange
    view.addSubview(dimmedView)
    view.addSubview(bottomSheetView)
  }

  func layout() {
    NSLayoutConstraint.activate([
      dimmedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      dimmedView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      dimmedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      dimmedView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),

      bottomSheetView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      bottomSheetView.heightAnchor.constraint(equalToConstant: 115),
      bottomSheetView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      bottomSheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
