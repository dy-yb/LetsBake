//
//  ViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/11/30.
//

import UIKit

class ExchangerViewController: UIViewController {

  let viewModel = ExchangerViewModel()

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
    textField.tintColor = .clear
    return textField
  }()
  
  let ingredientsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.tag = 1
    return pickerView
  }()

  let inputQuantityTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.textAlignment = .center
    textField.placeholder = "300"
    textField.keyboardType = .numberPad
    return textField
  }()
  
  let inputUnitsTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.placeholder = "그램"
    textField.textAlignment = .center
    textField.configToolbar()
    textField.tintColor = .clear
    return textField
  }()
  
  let inputUnitsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.tag = 2
    return pickerView
  }()

  let arrowImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "arrow_down")
    return imageView
  }()

  let resultQuantityTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .mainColor
    textField.layer.cornerRadius = 10
    textField.textAlignment = .center
    textField.tintColor = .clear
    return textField
  }()

  let resultUnitsTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .none
    textField.placeholder = "그램"
    textField.textAlignment = .center
    textField.configToolbar()
    textField.tintColor = .clear
    return textField
  }()

  let resultUnitsPickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.tag = 3
    return pickerView
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLayoutSubviews() {
    inputQuantityTextField.setUnderLineToTextField()
    inputUnitsTextField.setUnderLineToTextField()
    resultUnitsTextField.setUnderLineToTextField()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    layout()
    configPickerView()
    //    setData()
  }
  
  // MARK: - Layout
  
  func setView() {
    ingredientsTextField.delegate = self
    inputUnitsTextField.delegate = self
    resultUnitsTextField.delegate = self
    resultQuantityTextField.delegate = self

    view.backgroundColor = .white
    view.addSubview(questionLabel)
    view.addSubview(ingredientsTextField)
    view.addSubview(inputQuantityTextField)
    view.addSubview(inputUnitsTextField)
    view.addSubview(arrowImageView)
    view.addSubview(resultQuantityTextField)
    view.addSubview(resultUnitsTextField)
  }
  
  func layout() {
    NSLayoutConstraint.activate([
      questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
      questionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 33),

      // stackview?
      ingredientsTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
      ingredientsTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -222),
      ingredientsTextField.heightAnchor.constraint(equalToConstant: 40),
      ingredientsTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 33),
      
      inputQuantityTextField.topAnchor.constraint(equalTo: ingredientsTextField.topAnchor),
      inputQuantityTextField.leftAnchor.constraint(equalTo: ingredientsTextField.rightAnchor, constant: 21),
      inputQuantityTextField.heightAnchor.constraint(equalToConstant: 40),
      inputQuantityTextField.widthAnchor.constraint(equalToConstant: 50),
      
      inputUnitsTextField.topAnchor.constraint(equalTo: ingredientsTextField.topAnchor),
      inputUnitsTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -45),
      inputUnitsTextField.heightAnchor.constraint(equalToConstant: 40),
      inputUnitsTextField.leftAnchor.constraint(equalTo: inputQuantityTextField.rightAnchor, constant: 21),

      arrowImageView.topAnchor.constraint(equalTo: ingredientsTextField.bottomAnchor, constant: 45),
      arrowImageView.widthAnchor.constraint(equalToConstant: 45),
      arrowImageView.heightAnchor.constraint(equalToConstant: 35),
      arrowImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

      resultQuantityTextField.topAnchor.constraint(equalTo: arrowImageView.bottomAnchor, constant: 45),
      resultQuantityTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -170),
      resultQuantityTextField.heightAnchor.constraint(equalToConstant: 45),
      resultQuantityTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 33),

      resultUnitsTextField.bottomAnchor.constraint(equalTo: resultQuantityTextField.bottomAnchor),
      resultUnitsTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -45),
      resultUnitsTextField.leftAnchor.constraint(equalTo: resultQuantityTextField.rightAnchor, constant: 15),
      resultUnitsTextField.heightAnchor.constraint(equalToConstant: 40)
    ])
  }

  // MARK: - Funtions
  func setBinding() {
    viewModel.result.subscribe { value in
      DispatchQueue.main.async {
        self.resultQuantityTextField.text = value
      }
    }
  }

  //  private func setData() {
  //    if let inputQuatity = inputQuantityTextField.text,
  //       let inputUnit = inputUnitsTextField.text,
  //       let inputIngredient = ingredientsTextField.text,
  //       let resultUnit = resultUnitsTextField.text {
  //      let doubleQuantity = Double(inputQuatity) ?? 0
  //      self.resultQuantityTextField.text = String(viewModel.fetchData(inputIngredient: inputIngredient,
  //                                                                inputUnit: inputUnit,
  //                                                                inputQuantity: doubleQuantity,
  //                                                                resultUnit: resultUnit))
  //    }
  //  }
  //
  //  private func setResult() {
  //    //    resultTableView.dataSource = self
  //    setupBinding()
  //  }
  //
  //  private func setupBinding() {
  //    viewModel.storage.bind { [weak self] _ in
  //      guard let self = self else { return }
  //      self.resultQuantityTextField.reloadInputViews()
  //    }
  //
  //    /* Error Handling */
  //    let message = "에러 발생"
  //    viewModel.errorMessage = Observable(message)
  //    viewModel.error.bind { isSuccess in
  //      if isSuccess {
  //        print("DEBUG: success")
  //      } else {
  //        print("DEBUG: \(self.viewModel.errorMessage)")
  //      }
  //    }
  //  }
}

// MARK: - Extensions

extension ExchangerViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return false
  }
}

extension ExchangerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func configPickerView() {
    ingredientsPickerView.delegate = self
    ingredientsPickerView.dataSource = self
    ingredientsTextField.inputView = ingredientsPickerView
    
    inputUnitsPickerView.delegate = self
    inputUnitsPickerView.dataSource = self
    inputUnitsTextField.inputView = inputUnitsPickerView

    resultUnitsPickerView.delegate = self
    resultUnitsPickerView.dataSource = self
    resultUnitsTextField.inputView = resultUnitsPickerView
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    var numOfComponent: Int = 0
    
    switch pickerView {
    case ingredientsPickerView:
      numOfComponent = ingredients.count
    case inputUnitsPickerView, resultUnitsPickerView:
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
    case inputUnitsPickerView:
      titleRow = units[row]
    case resultUnitsPickerView:
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
    case inputUnitsPickerView:
      self.inputUnitsTextField.text = units[row]
    case resultUnitsPickerView:
      self.resultUnitsTextField.text = units[row]
    default:
      break;
    }
  }
}
