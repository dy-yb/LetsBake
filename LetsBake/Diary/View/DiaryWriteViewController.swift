//
//  DiaryWriteViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/13.
//

import UIKit

class DiaryWriteViewController: UITableViewController {

  // MARK: UI

  var titleInputCell = UITableViewCell()
  var dateInputCell = UITableViewCell()
//  var ingredientsInputCell = UITableViewCell()
//  var reciepeInputCell = UITableViewCell()
//  var starRatingInputCell = UITableViewCell()

  var titleTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "빵 이름"
    textField.frame = CGRect(x: 0, y: 0, width: 414, height: 44)
    return textField
  }()

  let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.preferredDatePickerStyle = .automatic
    datePicker.datePickerMode = .dateAndTime
    datePicker.locale = Locale(identifier: "ko-KR")
    datePicker.addTarget(self, action: #selector(hadleDatePicker(_:)), for: .valueChanged)
    return datePicker
  }()

  let button: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .blue
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "일지 작성"
    tableView.dataSource = self
    tableView.delegate = self
    setView()
    layout()
  }

  // MARK: - Layout

  func setView() {
    self.tableView.dataSource = self
    titleInputCell.backgroundColor = .lightGray
    titleInputCell.addSubview(titleTextField)
    dateInputCell.addSubview(datePicker)
    view.addSubview(button)
  }

  func layout() {
    NSLayoutConstraint.activate([
      titleTextField.topAnchor.constraint(equalTo: titleInputCell.contentView.topAnchor, constant: 5),
      titleTextField.leftAnchor.constraint(equalTo: titleInputCell.contentView.leftAnchor, constant: 5),
      titleTextField.rightAnchor.constraint(equalTo: titleInputCell.contentView.rightAnchor),
      titleTextField.bottomAnchor.constraint(equalTo: titleInputCell.contentView.bottomAnchor),

      datePicker.topAnchor.constraint(equalTo: dateInputCell.contentView.topAnchor),
      datePicker.leftAnchor.constraint(equalTo: dateInputCell.contentView.leftAnchor),
      datePicker.rightAnchor.constraint(equalTo: dateInputCell.contentView.rightAnchor),
      datePicker.bottomAnchor.constraint(equalTo: dateInputCell.contentView.bottomAnchor),

      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      button.widthAnchor.constraint(equalToConstant: 144),
      button.heightAnchor.constraint(equalToConstant: 40)
    ])
  }

  @objc func hadleDatePicker(_ sender: UIDatePicker) {
    print(sender.date)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch(indexPath.row) {
    case 0: return self.titleInputCell
    case 1: return self.dateInputCell
    default: fatalError("Unknown row in section 0")
    }
  }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
}
