//
//  DiaryIngredientsTableViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/15.
//

import UIKit

protocol DiaryIngredientsTableViewCellDelegate: AnyObject {
  func getIngredientData(ingredient: Ingredient)
}

class DiaryIngredientsTableViewCell: UITableViewCell {

  // MARK: - Constants

  enum TextFieldTag: Int {
    case ingredientName = 1
    case quantity = 2
    case unit = 3
  }

  // MARK: - Properties

  weak var delegate: DiaryIngredientsTableViewCellDelegate?
  var ingredient = Ingredient(ingredientName: "", quantity: 0, unit: "그램")

  // MARK: - UI

  lazy var cellStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [ingredientTextField, quantityTextField, unitsTextField])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    stackView.layer.cornerRadius = 10
    stackView.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
    return stackView
  }()

  let ingredientTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.placeholder = "재료"
    textField.tag = TextFieldTag.ingredientName.rawValue
    return textField
  }()

  lazy var quantityTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.placeholder = "양"
    textField.keyboardType = .numberPad
    textField.addTarget(self, action: #selector(editedTextField(_:)), for: .editingChanged)
    textField.tag = TextFieldTag.quantity.rawValue
    return textField
  }()

  lazy var unitsTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.configToolbar()
    textField.tintColor = .clear
    textField.tag = TextFieldTag.unit.rawValue
    return textField
  }()

  private let unitsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
    return pickerView
  }()

  lazy var ingredientConfirmButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "bt_diary_ingredient"), for: .normal)
    button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    button.addTarget(self, action: #selector(ingredientConfirmButtonDidTap(_:)), for: .touchUpInside)
    return button
  }()

  lazy var ingredientDeleteButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "bt_diary_ingredient"), for: .normal)
    button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    button.addTarget(self, action: #selector(ingredientDeleteButtonDidTap(_:)), for: .touchUpInside)
    return button
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
    ingredientTextField.delegate = self
    quantityTextField.delegate = self
    unitsTextField.delegate = self

    contentView.addSubview(cellStackView)
    contentView.addSubview(ingredientConfirmButton)
    contentView.addSubview(ingredientDeleteButton)
  }

  func layout() {
    NSLayoutConstraint.activate([
      ingredientConfirmButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 1),
      ingredientConfirmButton.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),

      ingredientDeleteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 1),
      ingredientDeleteButton.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),

      cellStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 1),
      cellStackView.heightAnchor.constraint(equalToConstant: 30),
      cellStackView.rightAnchor.constraint(equalTo: ingredientConfirmButton.leftAnchor, constant: -10),
      cellStackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor)
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

  @objc func ingredientConfirmButtonDidTap(_ sender: UIButton) {
    guard let ingredientName = ingredientTextField.text else { return }
    guard let quantity = quantityTextField.text else { return }
    guard let unit = unitsTextField.text else { return }

    UIView.animate(withDuration: 0.5, animations: {
      self.cellStackView.transform = CGAffineTransform(translationX: 25, y: 0)
    })
    self.ingredientConfirmButton.isHidden = true

    delegate?.getIngredientData(ingredient: Ingredient(ingredientName: ingredientName, quantity: Int(quantity) ?? 0, unit: unit))
  }

  @objc func ingredientDeleteButtonDidTap(_ sender: UIButton) {
  }
}

extension DiaryIngredientsTableViewCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField.tag == TextFieldTag.unit.rawValue {
      return false
    } else {
    return true
    }
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
