//
//  ImageCropHandler.swift
//  LetsBake
//
//  Created by Daye on 2022/02/28.
//

import Foundation
import UIKit

struct ImageCropHandler {

  // MARK: - Properties

  static let shardInstance = ImageCropHandler()

  func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, imageViewWidth: CGFloat, imageViewHeight: CGFloat) -> UIImage? {
    let imageViewScale = max(inputImage.size.width / imageViewWidth, inputImage.size.height / imageViewHeight)

    let cropZone = CGRect(x: cropRect.origin.x * imageViewScale, y: cropRect.origin.y * imageViewScale, width: cropRect.size.width * imageViewScale, height: cropRect.size.height * imageViewScale)

    guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to: cropZone) else { return nil }
    let croppedImage: UIImage = UIImage(cgImage: cutImageRef)

    return croppedImage
  }

}
