//
//  ExchangeResultTabelCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation
import UIKit

class ExchangeResultTableCell: UITableViewCell {
  
  // MARK: UI

  let unitNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  let resultLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setView()
    layout()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  func setView() {
    contentView.addSubview(unitNameLabel)
    contentView.addSubview(resultLabel)
  }

  func layout() {
    NSLayoutConstraint.activate([
      unitNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
      unitNameLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 20),

      resultLabel.topAnchor.constraint(equalTo: unitNameLabel.topAnchor),
      resultLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -20)
    ])
  }
}
