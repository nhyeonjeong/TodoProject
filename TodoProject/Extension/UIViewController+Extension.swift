//
//  UIViewController+Extension.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/20.
//

import UIKit

extension UIViewController {
    func saveImageToDocument(image: UIImage, filename: String) {
        // 앱의 Document폴더 위쳐오기 -> FileManager로 가져올 수 있다..
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}// Document말고도 Library등의 위치도 가져올 수 있다.
        
        // 이미지를 저장할 경로(파일명) 지정
        let fileUrl = documentDirectory.appendingPathComponent("\(filename).jpg")

        guard let data = image.jpegData(compressionQuality: 0.5) else {return}

        do {
            try data.write(to: fileUrl)
        } catch {
            print("file save error", error)
        }
    }
}
