//
//  DiaryIngredientsTableViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/15.
//

import UIKit

class DiaryIngredientsTableViewCell: UITableViewCell {

  // MARK: - UI

  let ingredientTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .green
    return textField
  }()

  let deleteingredientButton: UIButton = {
    let button = UIButton()
    return button
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
    contentView.addSubview(ingredientTextField)
  }

  func layout() {
    NSLayoutConstraint.activate([
      ingredientTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
      ingredientTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      ingredientTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      ingredientTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor)
    ])
  }
}
