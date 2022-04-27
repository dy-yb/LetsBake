//
//  DiaryCollectionViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/14.
//

import Foundation
import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  // MARK: - UI
  
  let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 10
    imageView.image = UIImage(named: "lemoncake")
    return imageView
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
//    label.text = "2022.01.04"
    label.font = .systemFont(ofSize: 15)
    label.backgroundColor = .white
    return label
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
//    label.text = "레몬 케이크"
    label.font = .boldSystemFont(ofSize: 19)
    label.backgroundColor = .white
    return label
  }()

  let deleteButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "bt_diary_delete"), for: .normal)
    button.isHidden = true
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setView()
    layout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setView() {
    contentView.layer.cornerRadius = 10

    contentView.addSubview(thumbnailImageView)
    contentView.addSubview(deleteButton)
    contentView.addSubview(dateLabel)
    contentView.addSubview(titleLabel)
  }

  func configure(diary: DiaryModel) {
    self.titleLabel.text = diary.title

//    self.dateLabel.text = diary.date
    print(diary)
    print("date\(diary.date)")
  }
  
  func layout() {
    NSLayoutConstraint.activate([
      thumbnailImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
      thumbnailImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
      thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
      thumbnailImageView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),

      deleteButton.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: -5),
      deleteButton.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 5),

      titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      titleLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 10),
      
      dateLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 10),
      dateLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5)
    ])
  }
}

extension DiaryCollectionViewCell: DiaryColletionViewDelegate {
  func removeModeEnabled() {
    self.deleteButton.isHidden = false
    
    print("hi")
  }
}
