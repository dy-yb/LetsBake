//
//  TimerTableViewCell.swift
//  LetsBake
//
//  Created by Daye on 2022/01/04.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
  // MARK: - Properties

  // MARK: - UI

  let timerTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Bake"
    return label
  }()

  let leftedTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "13:00"
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

  func setView(){

  }
  
  func layout() {

  }

}
