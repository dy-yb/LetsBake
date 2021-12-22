//
//  DiaryCollectionViewCell.swift
//  LetsBake
//
//  Created by Daye on 2021/12/14.
//

import Foundation
import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: .zero)
    contentView.backgroundColor = .lightGray
    contentView.layer.cornerRadius = 10
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
