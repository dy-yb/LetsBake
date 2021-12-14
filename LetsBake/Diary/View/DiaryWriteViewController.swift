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
  var ingredientsInputCell = UITableViewCell()
  var reciepeInputCell = UITableViewCell()
  var starRatingInputCell = UITableViewCell()

  var titleTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "빵 이름"
    textField.frame = CGRect(x: 0, y: 0, width: 414, height: 44)
    return textField
  }()

  let dateTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    textField.placeholder = "베이킹한 날짜"
    textField.frame = CGRect(x: 0, y: 0, width: 414, height: 44)
    return textField
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
    dateInputCell.addSubview(dateTextField)

  }

  func layout() {
    NSLayoutConstraint.activate([
      titleTextField.topAnchor.constraint(equalTo: titleInputCell.contentView.topAnchor, constant: 5),
      titleTextField.leftAnchor.constraint(equalTo: titleInputCell.contentView.leftAnchor, constant: 5),
      titleTextField.rightAnchor.constraint(equalTo: titleInputCell.contentView.rightAnchor),
      titleTextField.bottomAnchor.constraint(equalTo: titleInputCell.contentView.bottomAnchor),

      dateTextField.topAnchor.constraint(equalTo: dateInputCell.contentView.topAnchor),
      dateTextField.leftAnchor.constraint(equalTo: dateInputCell.contentView.leftAnchor),
      dateTextField.rightAnchor.constraint(equalTo: dateInputCell.contentView.rightAnchor),
      dateTextField.bottomAnchor.constraint(equalTo: dateInputCell.contentView.bottomAnchor)
    ])
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch(indexPath.row) {
    case 0: return self.titleInputCell  // section 0, row 0 is the first name
    case 1: return self.dateInputCell  // section 0, row 1 is the last name
    default: fatalError("Unknown row in section 0")
    }
  }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
}
