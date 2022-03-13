//
//  DiaryIngredientsTableViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/15.
//

import UIKit

class DiaryIngredientsTableViewCell: UITableViewCell {

  // MARK: - UI

  lazy var cellStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [ingredientTextField, quantityTextField, unitsTextField])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    return stackView
  }()

  let ingredientTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.placeholder = "재료"
    return textField
  }()

  private lazy var quantityTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.placeholder = "양"
    textField.keyboardType = .numberPad
    textField.addTarget(self, action: #selector(editedTextField(_:)), for: .editingChanged)
    return textField
  }()

  private lazy var unitsTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.configToolbar()
    textField.tintColor = .clear
    return textField
  }()

  private let unitsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
    return pickerView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setView()
    layout()
    configPickerView()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  // MARK: - layout

  func setView() {
    contentView.layer.cornerRadius = 10
    contentView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
    contentView.addSubview(cellStackView)
  }

  func layout() {
    NSLayoutConstraint.activate([
      cellStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 1),
      cellStackView.heightAnchor.constraint(equalToConstant: 30),
      cellStackView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -20),
      cellStackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 20)
    ])
  }

  // MARK: - functions
  func checkMaxLength(textField: UITextField, maxLength: Int) {
    if textField.text?.count ?? 0 > maxLength {
      textField.deleteBackward()
    }
  }
  @objc func editedTextField(_ sender: UITextField) {
    checkMaxLength(textField: sender, maxLength: 5)
  }
}

extension DiaryIngredientsTableViewCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return false
  }
}

extension DiaryIngredientsTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
  func configPickerView() {
    unitsPickerView.delegate = self
    unitsPickerView.dataSource = self
    unitsTextField.inputView = unitsPickerView
    unitsPickerView.selectedRow(inComponent: 0)
    unitsTextField.text = staticUnits[0]
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return staticUnits.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return staticUnits[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    unitsTextField.text = staticUnits[row]
  }
}
