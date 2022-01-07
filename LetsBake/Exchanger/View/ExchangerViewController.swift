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
    let imageView = UIImageView()
    imageView.image = UIImage(named: "ic_diary_50_off")
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .lightGray
    textField.rightView = imageView
    textField.layer.cornerRadius = 10
    textField.textAlignment = .center
    textField.placeholder = "강력분"
    return textField
  }()

  let ingredientsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
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
    return textField
  }()

  let unitsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
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
    configToolbar()
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
      numberTextField.widthAnchor.constraint(equalToConstant: 65),

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
  }

  func configToolbar() {
    let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.bounds.width, height: 44)))
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = .white
    toolBar.sizeToFit()

    let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
    doneButton.tintColor = .darkGray
    cancelButton.tintColor = .darkGray

    toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true

    ingredientsTextField.inputAccessoryView = toolBar
  }

  @objc func donePicker() {
    // why..?
    //    let row = self.ingredientsPickerView.selectedRow(inComponent: 0)
    //    self.ingredientsPickerView.selectRow(row, inComponent: 0, animated: false)
    //    self.ingredientsTextField.text = self.ingredients[row]
    self.ingredientsTextField.resignFirstResponder()
  }

  @objc func cancelPicker() {
    self.ingredientsTextField.text = nil
    self.ingredientsTextField.resignFirstResponder()
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ingredients.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ingredients[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.ingredientsTextField.text = self.ingredients[row]
  }
}
