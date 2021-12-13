//
//  TimerViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import UIKit

class TimerViewController: UIViewController {
  // MARK: - Properties
  // MARK: - UI
  let noteLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Timer View"
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
    view.addSubview(noteLabel)
  }

  func layout() {
    NSLayoutConstraint.activate([
      noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      noteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
