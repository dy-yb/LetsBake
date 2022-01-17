//
//  DiaryWriteViewController.swift
//  LetsBake
//
//  Created by Daye on 2021/12/13.
//

import UIKit

class DiaryWriteViewController: UIViewController {

  // MARK: - Properties

  var numberOfIngredients: Int = 3
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
    return view
  }()

  lazy var titleInputStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleInputLabel, titleTextField])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalCentering
    stackView.spacing = 20
    stackView.layer.addBorder([.bottom], color: .darkGray, width: view.frame.width)
    return stackView
  }()

  let titleInputLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "제목"
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  let titleTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "ex. 얼그레이 마들렌(15자 이내)"
    textField.textAlignment = .right
    textField.isUserInteractionEnabled = true
    return textField
  }()
  
  lazy var dateInputStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [dateInputLabel, datePicker])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalCentering
    stackView.spacing = 10
    stackView.layer.borderColor = UIColor.darkGray.cgColor
    return stackView
  }()

  let dateInputLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "날짜"
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.preferredDatePickerStyle = .compact
    datePicker.datePickerMode = .dateAndTime
    datePicker.locale = Locale(identifier: "ko-KR")
    datePicker.addTarget(self, action: #selector(hadleDatePicker(_:)), for: .valueChanged)
    return datePicker
  }()

  let ingredientsInputView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let ingredientsInputLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "재료"
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  let ingredientsTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(DiaryIngredientsTableViewCell.classForCoder(), forCellReuseIdentifier: cellID)
    tableView.separatorColor = .white
    return tableView
  }()

  lazy var addIngredintButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "bt_diary_ingredient"), for: .normal)
    button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    button.addTarget(self, action: #selector(addIngredients), for: .touchUpInside)
    return button
  }()

  let receipeInputView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let receipeInputLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "상세 레시피"
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  let receipeTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = .lightGray
    textView.layer.cornerRadius = 10
    return textView
  }()

  lazy var ratingSlider: TapUISlider = {
    let slider = TapUISlider()
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.maximumValue = 5
    slider.minimumValue = 0
    slider.maximumTrackTintColor = .clear
    slider.minimumTrackTintColor = .clear
    slider.thumbTintColor = .clear
    slider.addTarget(self, action: #selector(tapSlider(_:)), for: .valueChanged)
    return slider
  }()

  lazy var ratingStarStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    return stackView
  }()

  let ratingLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "이번 베이킹은 어땠나요?"
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  private var starImageViews: [UIImageView] = []

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
    setRatingImageView()
    setView()
    layout()
  }

  override func viewDidAppear(_ animated: Bool) {
    titleInputStackView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
    dateInputStackView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
    ingredientsInputView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
    receipeInputView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
  }

  // MARK: - Layout

  func setView() {
    view.backgroundColor = .white
    ingredientsTableView.rowHeight = UITableView.automaticDimension
    ingredientsTableView.dataSource = self
    ingredientsTableView.delegate = self

    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    view.addSubview(doneButton)
    contentView.addSubview(titleInputStackView)
    contentView.addSubview(dateInputStackView)
    contentView.addSubview(ingredientsInputLabel)
    contentView.addSubview(ingredientsInputView)
    contentView.addSubview(ratingLabel)
    contentView.addSubview(ratingStarStackView)
    contentView.addSubview(ratingSlider)

    ingredientsInputView.addSubview(ingredientsInputLabel)
    ingredientsInputView.addSubview(ingredientsTableView)
    ingredientsInputView.addSubview(addIngredintButton)
    contentView.addSubview(receipeInputView)
    receipeInputView.addSubview(receipeInputLabel)
    receipeInputView.addSubview(receipeTextView)
  }

  func layout() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),

      contentView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
      // 작은 화면에서 스크롤 안되는 문제 해결 해야함
      contentView.heightAnchor.constraint(equalToConstant: scrollView.frame.height+100),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),

      titleInputStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
      titleInputStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
      titleInputStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
      titleInputStackView.heightAnchor.constraint(equalToConstant: 60),

      dateInputStackView.topAnchor.constraint(equalTo: titleInputStackView.bottomAnchor),
      dateInputStackView.rightAnchor.constraint(equalTo: titleInputStackView.rightAnchor),
      dateInputStackView.leftAnchor.constraint(equalTo: titleInputStackView.leftAnchor),
      dateInputStackView.heightAnchor.constraint(equalToConstant: 60),

      ingredientsInputView.topAnchor.constraint(equalTo: dateInputStackView.bottomAnchor, constant: 25),
      ingredientsInputView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
      ingredientsInputView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
      ingredientsInputView.heightAnchor.constraint(equalToConstant: 220),

      ingredientsInputLabel.topAnchor.constraint(equalTo: ingredientsInputView.topAnchor),
      ingredientsInputLabel.leftAnchor.constraint(equalTo: ingredientsInputView.leftAnchor),
      ingredientsInputLabel.heightAnchor.constraint(equalToConstant: 20),

      ingredientsTableView.topAnchor.constraint(equalTo: ingredientsInputLabel.bottomAnchor, constant: 10),
      ingredientsTableView.rightAnchor.constraint(equalTo: ingredientsInputView.rightAnchor),
      ingredientsTableView.bottomAnchor.constraint(equalTo: ingredientsInputView.bottomAnchor, constant: -40),
      ingredientsTableView.leftAnchor.constraint(equalTo: ingredientsInputView.leftAnchor),

      addIngredintButton.bottomAnchor.constraint(equalTo: ingredientsInputView.bottomAnchor, constant: -25),
      addIngredintButton.rightAnchor.constraint(equalTo: ingredientsInputView.rightAnchor, constant: -10),

      receipeInputView.topAnchor.constraint(equalTo: ingredientsInputView.bottomAnchor, constant: 20),
      receipeInputView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
      receipeInputView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
      receipeInputView.heightAnchor.constraint(equalToConstant: 400),

      receipeInputLabel.topAnchor.constraint(equalTo: receipeInputView.topAnchor),
      receipeInputLabel.leftAnchor.constraint(equalTo: receipeTextView.leftAnchor),

      receipeTextView.topAnchor.constraint(equalTo: receipeInputLabel.bottomAnchor, constant: 10),
      receipeTextView.leftAnchor.constraint(equalTo: receipeInputView.leftAnchor),
      receipeTextView.rightAnchor.constraint(equalTo: receipeInputView.rightAnchor),
      receipeTextView.bottomAnchor.constraint(equalTo: receipeInputView.bottomAnchor, constant: -30),

      ratingLabel.topAnchor.constraint(equalTo: receipeInputView.bottomAnchor, constant: 20),
      ratingLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),

      ratingSlider.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
      ratingSlider.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      ratingSlider.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -200),
      ratingSlider.heightAnchor.constraint(equalToConstant: 50),

      ratingStarStackView.topAnchor.constraint(equalTo: ratingSlider.topAnchor),
      ratingStarStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      ratingStarStackView.widthAnchor.constraint(equalTo: ratingSlider.widthAnchor),
      ratingStarStackView.heightAnchor.constraint(equalTo: ratingSlider.heightAnchor),

      doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      doneButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      doneButton.heightAnchor.constraint(equalToConstant: 80)
    ])
  }

  func setRatingImageView() {
    for index in 0..<5 {
      let imageView = UIImageView()
      imageView.image = UIImage(named: "ic_rating_off")
      imageView.tag = index
      ratingStarStackView.addArrangedSubview(imageView)
      starImageViews.append(ratingStarStackView.subviews[index] as? UIImageView ?? UIImageView())
    }
  }

  @objc func hadleDatePicker(_ sender: UIDatePicker) {
    print(sender.date)
  }

  @objc func addIngredients(_ sender: Any) {
    numberOfIngredients += 1
    ingredientsTableView.reloadData()
  }

  @objc func tapSlider(_ sender: UISlider) {
    var intValue = Int(ceil(sender.value))

    for index in 0..<5 {
      if intValue == 1 {
        intValue -= 1
        starImageViews[index].image = UIImage(named: "ic_rating_on")
      } else if index < intValue {
        starImageViews[index].image = UIImage(named: "ic_rating_on")
      } else {
        starImageViews[index].image = UIImage(named: "ic_rating_off")
      }
    }
  }

}

extension DiaryWriteViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfIngredients
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let diaryIngredientsTableViewCell = tableView.dequeueReusableCell(withIdentifier: DiaryWriteViewController.cellID, for: indexPath) as? DiaryIngredientsTableViewCell else {
      return .init()
    }
    return diaryIngredientsTableViewCell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.rowHeight
  }
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.beginUpdates()
      tableView.deleteRows(at: [indexPath], with: .fade)
      tableView.endUpdates()
    }
  }
}
