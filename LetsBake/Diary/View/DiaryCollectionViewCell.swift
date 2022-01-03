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
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    contentView.backgroundColor = .lightGray
    contentView.layer.cornerRadius = 10
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
