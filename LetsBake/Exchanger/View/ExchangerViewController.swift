//
//  ViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/11/30.
//

import UIKit

class ExchangerViewController: UIViewController {

  // MARK: - Properties

  let ingredients = ["강력분", "중력분", "박력분"]
  let units = ["teaspoon", "tablespoon", "cup", "ounce", "milliliter"]

  // MARK: - UI

  let questionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "무엇을 변환할까요?"
    label.font = .boldSystemFont(ofSize: 25)
    return label
  }()

  let ingredientsTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .lightGray
    textField.layer.cornerRadius = 10
    textField.textAlignment = .center
    textField.placeholder = "강력분"
    textField.configToolbar()
    return textField
  }()

  let ingredientsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.tag = 1
    return pickerView
  }()

  let numberTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.placeholder = "300"
    return textField
  }()

  let unitsTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.placeholder = "그램"
    textField.textAlignment = .center
    textField.configToolbar()
    return textField
  }()

  let unitsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.tag = 2
    return pickerView
  }()

  lazy var resultButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 10
    button.backgroundColor = .mainColor
    button.setTitle("결과보기", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(resultButtonEvent), for: .touchUpInside)
    return button
  }()

  // MARK: - Lifecycle

  override func viewDidLayoutSubviews() {
    numberTextField.setUnderLineToTextField()
    unitsTextField.setUnderLineToTextField()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    layout()
    configPickerView()
  }

  // MARK: - Layout

  func setView() {
    view.backgroundColor = .white
    view.addSubview(questionLabel)
    view.addSubview(ingredientsTextField)
    view.addSubview(numberTextField)
    view.addSubview(unitsTextField)
    view.addSubview(resultButton)
  }

  func layout() {
    NSLayoutConstraint.activate([
      questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
      questionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 33),

      ingredientsTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
      ingredientsTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -222),
      ingredientsTextField.heightAnchor.constraint(equalToConstant: 40),
      ingredientsTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 33),

      numberTextField.topAnchor.constraint(equalTo: ingredientsTextField.topAnchor),
      numberTextField.leftAnchor.constraint(equalTo: ingredientsTextField.rightAnchor, constant: 21),
      numberTextField.heightAnchor.constraint(equalToConstant: 40),
      numberTextField.widthAnchor.constraint(equalToConstant: 50),

      unitsTextField.topAnchor.constraint(equalTo: ingredientsTextField.topAnchor),
      unitsTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -45),
      unitsTextField.heightAnchor.constraint(equalToConstant: 40),
      unitsTextField.leftAnchor.constraint(equalTo: numberTextField.rightAnchor, constant: 21),

      resultButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 30),
      resultButton.leftAnchor.constraint(equalTo: ingredientsTextField.leftAnchor),
      resultButton.rightAnchor.constraint(equalTo: unitsTextField.rightAnchor),
      resultButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  @objc func resultButtonEvent() {
    let exchangerResultViewController = ExchangerResultViewController()
    exchangerResultViewController.modalPresentationStyle = .overFullScreen
    self.present(exchangerResultViewController, animated: false, completion: nil)
  }
}

// MARK: Extensions

extension ExchangerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func configPickerView() {
    ingredientsPickerView.delegate = self
    ingredientsPickerView.dataSource = self
    ingredientsTextField.inputView = ingredientsPickerView

    unitsPickerView.delegate = self
    unitsPickerView.dataSource = self
    unitsTextField.inputView = unitsPickerView
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    var numOfComponent: Int = 0

    switch pickerView {
    case ingredientsPickerView:
      numOfComponent = ingredients.count
    case unitsPickerView:
      numOfComponent = units.count
    default:
      break;
    }
    return numOfComponent
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    var titleRow: String?

    switch pickerView {
    case ingredientsPickerView:
      titleRow = ingredients[row]
    case unitsPickerView:
      titleRow = units[row]
    default:
      break;
    }
    return titleRow
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch pickerView {
    case ingredientsPickerView:
      self.ingredientsTextField.text = ingredients[row]
    case unitsPickerView:
      self.unitsTextField.text = units[row]
    default:
      break;
    }
  }
}
