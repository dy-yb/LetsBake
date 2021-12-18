//
//  DiaryIngredientsTableViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/15.
//

import UIKit

class DiaryIngredientsTableViewCell: UITableViewCell {

  // MARK: - UI

  let cellView: UIView = {
    let view = UIView()
    return view
  }()

  let ingredientTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .green
    return textField
  }()

  let deleteingredientButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .orange
    button.imageView?.image = UIImage(named: "bt_diary_ingre_delete")
    button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
    return button
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setView()
    layout()
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  func setView() {
    contentView.addSubview(ingredientTextField)
    contentView.addSubview(deleteingredientButton)
  }

  func layout() {
    contentView.layer.cornerRadius = 10
    ingredientTextField.frame = CGRect(x: 0, y: 0, width: (contentView.frame.width - 20), height: 30)
    NSLayoutConstraint.activate([

      ingredientTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
      ingredientTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20),
      ingredientTextField.heightAnchor.constraint(equalToConstant: 30),
//      ingredientTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//      ingredientTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      ingredientTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor),

      deleteingredientButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
      deleteingredientButton.leftAnchor.constraint(equalTo: ingredientTextField.rightAnchor, constant: 10),
      deleteingredientButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
    ])
  }
}
