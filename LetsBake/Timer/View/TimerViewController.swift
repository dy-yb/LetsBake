//
//  TimerViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

class TimerViewController: UIViewController {
  // MARK: - Properties

  static let cellID = "TimerViewCell"

  // MARK: - UI

  let timerTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(TimerViewController.classForCoder(), forCellReuseIdentifier: TimerViewController.cellID)
    return tableView
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
  }

  func layout() {
    NSLayoutConstraint.activate([
      timerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      timerTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      timerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      timerTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
    ])
  }
}
