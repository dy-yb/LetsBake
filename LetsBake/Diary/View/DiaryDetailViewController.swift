//
//  DiaryDetailViewController.swift
//  LetsBake
//
//  Created by Daye on 2022/01/15.
//

import UIKit

class DiaryDetailViewController: UIViewController {

  // MARK: - Properties

  var numberOfIngredients: Int = 3
  static let cellID = "DiaryIngredientCell"

  // MARK: - UI

  lazy var rightEditButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editDiary(_:)))
    button.tag = 1
    return button
  }()

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

  lazy var titleStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleHeaderLabel, titleContentLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalCentering
    stackView.spacing = 20
    stackView.layer.addBorder([.bottom], color: .darkGray, width: view.frame.width)
    return stackView
  }()

  let titleHeaderLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "제목"
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  let titleContentLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "레몬 케이크"
    label.textAlignment = .right
    return label
  }()

  lazy var dateStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [dateHeaderLabel, dateContentLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalCentering
    stackView.spacing = 10
    stackView.layer.borderColor = UIColor.darkGray.cgColor
    return stackView
  }()

  let dateHeaderLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "날짜"
    label.font = .boldSystemFont(ofSize: 17)
    return label
  }()

  let dateContentLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let ingredientsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let ingredientsHeaderLabel: UILabel = {
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

  let receipeView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let receipeHeaderLabel: UILabel = {
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
    textView.isEditable = false
    return textView
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

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "일지 보기"
    navigationItem.rightBarButtonItem = rightEditButton
    setRatingImageView()
    setView()
    layout()
  }

  override func viewDidAppear(_ animated: Bool) {
    titleStackView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
    dateStackView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
    ingredientsView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
    receipeView.layer.addBorder([.bottom], color: .darkGray, width: 1.0)
  }

  // MARK: - Layout

  func setView() {
    view.backgroundColor = .white
    ingredientsTableView.rowHeight = UITableView.automaticDimension
    ingredientsTableView.dataSource = self
    ingredientsTableView.delegate = self

    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(titleStackView)
    contentView.addSubview(dateStackView)
    contentView.addSubview(ingredientsHeaderLabel)
    contentView.addSubview(ingredientsView)
    contentView.addSubview(ratingLabel)
    contentView.addSubview(ratingStarStackView)

    ingredientsView.addSubview(ingredientsHeaderLabel)
    ingredientsView.addSubview(ingredientsTableView)
    contentView.addSubview(receipeView)
    receipeView.addSubview(receipeHeaderLabel)
    receipeView.addSubview(receipeTextView)
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

      titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
      titleStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
      titleStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
      titleStackView.heightAnchor.constraint(equalToConstant: 60),

      dateStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
      dateStackView.rightAnchor.constraint(equalTo: titleStackView.rightAnchor),
      dateStackView.leftAnchor.constraint(equalTo: titleStackView.leftAnchor),
      dateStackView.heightAnchor.constraint(equalToConstant: 60),

      ingredientsView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 25),
      ingredientsView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
      ingredientsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
      ingredientsView.heightAnchor.constraint(equalToConstant: 220),

      ingredientsHeaderLabel.topAnchor.constraint(equalTo: ingredientsView.topAnchor),
      ingredientsHeaderLabel.leftAnchor.constraint(equalTo: ingredientsView.leftAnchor),
      ingredientsHeaderLabel.heightAnchor.constraint(equalToConstant: 20),

      ingredientsTableView.topAnchor.constraint(equalTo: ingredientsHeaderLabel.bottomAnchor, constant: 10),
      ingredientsTableView.rightAnchor.constraint(equalTo: ingredientsView.rightAnchor),
      ingredientsTableView.bottomAnchor.constraint(equalTo: ingredientsView.bottomAnchor, constant: -40),
      ingredientsTableView.leftAnchor.constraint(equalTo: ingredientsView.leftAnchor),

      receipeView.topAnchor.constraint(equalTo: ingredientsView.bottomAnchor, constant: 20),
      receipeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
      receipeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
      receipeView.heightAnchor.constraint(equalToConstant: 400),

      receipeHeaderLabel.topAnchor.constraint(equalTo: receipeView.topAnchor),
      receipeHeaderLabel.leftAnchor.constraint(equalTo: receipeTextView.leftAnchor),

      receipeTextView.topAnchor.constraint(equalTo: receipeHeaderLabel.bottomAnchor, constant: 10),
      receipeTextView.leftAnchor.constraint(equalTo: receipeView.leftAnchor),
      receipeTextView.rightAnchor.constraint(equalTo: receipeView.rightAnchor),
      receipeTextView.bottomAnchor.constraint(equalTo: receipeView.bottomAnchor, constant: -30),

      ratingLabel.topAnchor.constraint(equalTo: receipeView.bottomAnchor, constant: 20),
      ratingLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),

      ratingStarStackView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
      ratingStarStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      ratingStarStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -200),
      ratingStarStackView.heightAnchor.constraint(equalToConstant: 50)
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

  @objc func editDiary(_ send: Any) {
    self.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(DiaryWriteViewController(), animated: true)
    print("called")
  }
}

extension DiaryDetailViewController: UITableViewDataSource, UITableViewDelegate {
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
