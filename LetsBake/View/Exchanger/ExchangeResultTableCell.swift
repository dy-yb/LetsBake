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

  let ingredientLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 13)
    return label
  }()

  let resultLabel: UILabel = {
    let label = UILabel()
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
    contentView.backgroundColor = .orange

  }

  func layout() {
    NSLayoutConstraint.activate([
    ])
  }
}
