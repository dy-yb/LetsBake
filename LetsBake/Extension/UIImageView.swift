//
//  UIImageView.swift
//  LetsBake
//
//  Created by Daye on 2022/02/28.
//

import Foundation
import UIKit

extension UIImageView {
  func realImageRect() -> CGRect {
    let imageViewSize = self.frame.size
    let imgSize = self.image?.size

    guard let imageSize = imgSize else {
      return CGRect.zero
    }

    let scaleWidth = imageViewSize.width / imageSize.width
    let scaleHeight = imageViewSize.height / imageSize.height
    let aspect = fmin(scaleWidth, scaleHeight)

    var imageRect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height * aspect)

    imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
    imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2

    imageRect.origin.x += self.frame.origin.x
    imageRect.origin.y += self.frame.origin.y

    return imageRect
  }
}
