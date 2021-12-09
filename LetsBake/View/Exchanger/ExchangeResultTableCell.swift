//
//  ExchangeResultTabelCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation
import UIKit

class ExchangeResultTableCell: UITableViewCell {

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
