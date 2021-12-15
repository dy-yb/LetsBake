//
//  DiaryWriteViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/13.
//

import UIKit

class DiaryWriteViewController: UIViewController {

  // MARK: - Properties

  static let cellID = "DiaryIngredientCell"

  // MARK: - UI

  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView(frame: view.bounds)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .purple
    return view
  }()

  lazy var titleInputStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleInputLabel, titleTextField])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .yellow
    stackView.alignment = .bottom
    return stackView
  }()

  let titleInputLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "제목"
    return label
  }()

  let titleTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "ex. 얼그레이 마들렌"
    textField.isUserInteractionEnabled = true

    return textField
  }()

  lazy var dateInputStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [dateInputLabel, datePicker])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .yellow
    stackView.alignment = .bottom
    return stackView
  }()

  let dateInputLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "날짜"
    return label
  }()

  lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.preferredDatePickerStyle = .automatic
    datePicker.datePickerMode = .dateAndTime
    datePicker.locale = Locale(identifier: "ko-KR")
    datePicker.addTarget(self, action: #selector(hadleDatePicker(_:)), for: .valueChanged)
    return datePicker
  }()

  lazy var ingredientsInputStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [ingredientsTableView, addIngredintButton])
    stackView.axis = .vertical
    stackView.alignment = .center
    return stackView
  }()

  let ingredientsInputLabel: UILabel = {
    let label = UILabel()
    label.text = "재료"
    return label
  }()

  let ingredientsTableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()

  let addIngredintButton: UIButton = {
    let button = UIButton()
    button.imageView?.image = UIImage(named: "bt_diary_ingredient")
    button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    button.addTarget(self, action: #selector(addIngredients), for: .touchUpInside)
    return button
  }()

  let doneButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("작성 완료", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = .mainColor
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "일지 작성"
    setView()
    layout()
  }

  // MARK: - Layout

  func setView() {
    view.backgroundColor = .white
    ingredientsTableView.dataSource = self

    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(doneButton)
    contentView.addSubview(titleInputStackView)
    contentView.addSubview(dateInputStackView)
    contentView.addSubview(ingredientsInputLabel)
//    contentView.addSubview(ingredientsInputStackView)
  }

  func layout() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),

      contentView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
      contentView.heightAnchor.constraint(equalToConstant: scrollView.frame.height),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),

      titleInputStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
      titleInputStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
      titleInputStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
      titleInputStackView.heightAnchor.constraint(equalToConstant: 30),

      titleInputLabel.topAnchor.constraint(equalTo: titleInputStackView.topAnchor),
      titleInputLabel.leftAnchor.constraint(equalTo: titleInputStackView.leftAnchor),

      titleTextField.topAnchor.constraint(equalTo: titleInputStackView.topAnchor),
      titleTextField.leftAnchor.constraint(equalTo: titleInputLabel.rightAnchor, constant: 20),
      titleTextField.heightAnchor.constraint(equalToConstant: 30),
      titleTextField.rightAnchor.constraint(equalTo: titleInputStackView.rightAnchor),

      dateInputStackView.topAnchor.constraint(equalTo: titleInputStackView.bottomAnchor, constant: 20),
      dateInputStackView.rightAnchor.constraint(equalTo: titleInputStackView.rightAnchor),
      dateInputStackView.leftAnchor.constraint(equalTo: titleInputStackView.leftAnchor),
      dateInputStackView.heightAnchor.constraint(equalToConstant: 30),

      dateInputLabel.topAnchor.constraint(equalTo: dateInputStackView.topAnchor, constant: 5),
      dateInputLabel.leftAnchor.constraint(equalTo: dateInputStackView.leftAnchor),

      datePicker.topAnchor.constraint(equalTo: dateInputStackView.topAnchor),
      datePicker.leftAnchor.constraint(equalTo: dateInputLabel.rightAnchor, constant: 20),

      ingredientsInputLabel.topAnchor.constraint(equalTo: dateInputStackView.bottomAnchor, constant: 20),
      ingredientsInputLabel.leftAnchor.constraint(equalTo: dateInputStackView.leftAnchor),
      ingredientsInputLabel.heightAnchor.constraint(equalToConstant: 30),

//      ingredientsInputStackView.topAnchor.constraint(equalTo: dateInputLabel.bottomAnchor, constant: 20),
//      ingredientsInputStackView.rightAnchor.constraint(equalTo: titleInputStackView.rightAnchor),
//      // 나중에 동적높이로 변경하기
//      ingredientsInputStackView.heightAnchor.constraint(equalToConstant: 300),
//      ingredientsInputStackView.leftAnchor.constraint(equalTo: titleInputStackView.leftAnchor),
//
//      ingredientsTableView.topAnchor.constraint(equalTo: ingredientsInputStackView.topAnchor),
//      ingredientsTableView.rightAnchor.constraint(equalTo: ingredientsInputStackView.rightAnchor),
//      ingredientsTableView.bottomAnchor.constraint(equalTo: ingredientsInputStackView.bottomAnchor, constant: -40),
//      ingredientsTableView.leftAnchor.constraint(equalTo: ingredientsInputStackView.leftAnchor),
//
//      addIngredintButton.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor, constant: 10),

      doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      doneButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      doneButton.heightAnchor.constraint(equalToConstant: 80)
    ])
  }

  @objc func hadleDatePicker(_ sender: UIDatePicker) {
    print(sender.date)
  }

  @objc func addIngredients(_ sender: Any){
    print("Ingredient")
  }
}

extension DiaryWriteViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let diaryIngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: DiaryWriteViewController.cellID, for: indexPath) as? DiaryIngredientsTableViewCell else {
      return .init()
    }
    return diaryIngredientsTableViewCell
  }

}
