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
  let unitArray = ["그램", "킬로그램", "티스푼", "테이블스푼", "컵", "온스", "밀리리터", "리터"]
  let resultArray = ["1 g", "0.01 kg", "0.13 tsp", "0.4 tbsp", "0.01 cup", "0.04 onz", "2 ml", "0.002 L"]

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
    tableView.separatorColor = .lightGray
    tableView.separatorInset.right = tableView.separatorInset.left
    tableView.register(ExchangeResultTableCell.classForCoder(), forCellReuseIdentifier: cellID)
    tableView.allowsSelection = false
    tableView.rowHeight = 44
    return tableView
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    resultTableView.dataSource = self 
    setView()
    layout()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showBottomSheet()
  }

  // MARK: - Layout

  func setView() {
    view.addSubview(dimmedView)
    view.addSubview(resultBottomSheetView)
    resultBottomSheetView.addSubview(resultTableView)
    dimmedView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:))))
    dimmedView.isUserInteractionEnabled = true
  }

  func layout() {
    NSLayoutConstraint.activate([
      dimmedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      dimmedView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      dimmedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      dimmedView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),

      resultBottomSheetView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      resultBottomSheetView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      resultBottomSheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

      resultTableView.topAnchor.constraint(equalTo: resultBottomSheetView.topAnchor, constant: 30),
      resultTableView.rightAnchor.constraint(equalTo: resultBottomSheetView.rightAnchor),
      resultTableView.bottomAnchor.constraint(equalTo: resultBottomSheetView.safeAreaLayoutGuide.bottomAnchor),
      resultTableView.leftAnchor.constraint(equalTo: resultBottomSheetView.leftAnchor)
    ])
  }

  // MARK: Functions

  func showBottomSheet() {
    resultBottomSheetView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedView.alpha = 0.7
      self.view.layoutIfNeeded()
    }, completion: nil)
  }

  func hideBottomSheet() {
    print("112")
    resultTableView.isHidden = true
    resultBottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedView.alpha = 0.0
      self.view.layoutIfNeeded()
    }) { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    }
  }
  @objc func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    hideBottomSheet()
  }
}

extension ExchangerResultViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return resultArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let exchangeResultTableCell = tableView.dequeueReusableCell(withIdentifier: ExchangerResultViewController.cellID, for: indexPath) as? ExchangeResultTableCell else {
      return .init()
    }

    exchangeResultTableCell.unitNameLabel.text = unitArray[indexPath.row]
    exchangeResultTableCell.resultLabel.text = resultArray[indexPath.row]

    return exchangeResultTableCell
  }
}
