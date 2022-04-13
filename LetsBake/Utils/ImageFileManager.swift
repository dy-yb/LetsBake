//
//  ImageFileManager.swift
//  LetsBake
//
//  Created by Daye on 2022/04/13.
//

import Foundation
import UIKit

class ImageFileManager {
  func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}

    let imageURL = documentDirectory.appendingPathComponent(imageName)

    guard let data = image.pngData() else {
      print("압축이 실패했습니다.")
      return
    }

    if FileManager.default.fileExists(atPath: imageURL.path) {
      do {
        try FileManager.default.removeItem(at: imageURL)
        print("이미지 삭제 완료")
      } catch {
        print("이미지를 삭제하지 못했습니다.")
      }
    }

    do {
      try data.write(to: imageURL)
      print("이미지 저장완료")
    } catch {
      print("이미지를 저장하지 못했습니다.")
    }
  }
}
