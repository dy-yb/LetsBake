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
  let result = returnRatios()

  // MARK: - UI

  let dimmedView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
    return view
  }()

  let resultBottomSheetView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.roundCorners(cornerRadius: 25, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    return view
  }()

  let resultTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorColor = .white
    tableView.register(ExchangeResultTableCell.classForCoder(), forCellReuseIdentifier: cellID)
    tableView.allowsSelection = true
    return tableView
  }()
  
  let unitNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let resultLabel: UILabel = {
    let label = UILabel()
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
    view.addSubview(dimmedView)
    view.addSubview(resultBottomSheetView)
    resultBottomSheetView.addSubview(resultTableView)
  }

  func layout() {
    NSLayoutConstraint.activate([
      dimmedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      dimmedView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      dimmedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      dimmedView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),

      resultBottomSheetView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      resultBottomSheetView.heightAnchor.constraint(equalToConstant: 300),
      resultBottomSheetView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      resultBottomSheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

      resultTableView.topAnchor.constraint(equalTo: resultBottomSheetView.topAnchor, constant: 15),
      resultTableView.rightAnchor.constraint(equalTo: resultBottomSheetView.rightAnchor),
      resultTableView.bottomAnchor.constraint(equalTo: resultBottomSheetView.safeAreaLayoutGuide.bottomAnchor),
      resultTableView.leftAnchor.constraint(equalTo: resultBottomSheetView.leftAnchor)
    ])
  }
}

extension ExchangerResultViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return result.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let exchangeResultTableCell = tableView.dequeueReusableCell(withIdentifier: ExchangerResultViewController.cellID, for: indexPath) as? ExchangeResultTableCell else {
      return .init()
    }
    return exchangeResultTableCell
  }
}
