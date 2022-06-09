//
//  DiaryIngredientsTableViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/15.
//

import UIKit

class DiaryIngredientsTableViewCell: UITableViewCell {

  // MARK: - Properties

  let ingredientView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
    view.layer.cornerRadius = 10
    return view
  }()

  let ingredientLabel: UILabel = {
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

  // MARK: - layout

  func setView() {
    contentView.addSubview(ingredientView)
    ingredientView.addSubview(ingredientLabel)
  }

  func layout() {
    NSLayoutConstraint.activate([
      ingredientView.heightAnchor.constraint(equalToConstant: 30),
      ingredientView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 2),
      ingredientView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -5),
      ingredientView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: -1),

      ingredientLabel.centerXAnchor.constraint(equalTo: ingredientView.centerXAnchor),
      ingredientLabel.centerYAnchor.constraint(equalTo: ingredientView.centerYAnchor)
    ])
  }
}
