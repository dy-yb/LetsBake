//
//  ViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/11/30.
//

import UIKit

class ExchangerViewController: UIViewController {
  // MARK: - Properties
  // MARK: - UI
  let noteLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Exchanger View"
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
    navigationItem.title = "계량 도우미"
    view.addSubview(noteLabel)
  }

  func layout() {
    NSLayoutConstraint.activate([
      noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      noteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
