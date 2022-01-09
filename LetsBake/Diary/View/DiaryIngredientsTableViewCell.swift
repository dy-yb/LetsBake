//
//  DiaryIngredientsTableViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/15.
//

import UIKit

class DiaryIngredientsTableViewCell: UITableViewCell {

  // MARK: - UI

  let cellStackView: UIView = {
    let view = UIView()
    return view
  }()

  let ingredientTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .green
    return textField
  }()

  let deleteingredientButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "bt_diary_ingre_delete"), for: .normal) 
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
    contentView.layer.cornerRadius = 10
    contentView.backgroundColor = .magenta
    contentView.addSubview(ingredientTextField)
  }

  func layout() {
    ingredientTextField.frame = CGRect(x: 0, y: 0, width: (contentView.frame.width - 20), height: 30)
    NSLayoutConstraint.activate([
      ingredientTextField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
      ingredientTextField.heightAnchor.constraint(equalToConstant: 30),
      ingredientTextField.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -30),
      ingredientTextField.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 20)
    ])
  }
}
