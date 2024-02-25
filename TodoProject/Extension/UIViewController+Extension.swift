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
    // 이미지 가져오기
    func loadImageToDocument(filename: String) -> UIImage? {
            
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                                                                         in: .userDomainMask).first else {return nil}
        // 경로만들어주기
        let fileUrl = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileUrl.path()) {
            return UIImage(contentsOfFile: fileUrl.path())
        } else {
            return UIImage(systemName: "start.fill")
        }
    }
    
    // remove
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let fileUrl = documentDirectory.appendingPathComponent("\(filename).jpg") // 존재한다면 제거
        // bool타입을 반환하는 fileExists
        if FileManager.default.fileExists(atPath: fileUrl.path()) {
            do {
                // atPath: 라면 String들어가고 at: 라면 Url타입이 들어간다
                try FileManager.default.removeItem(atPath: fileUrl.path()) // removeItem은 throw으로 더닞고 있으니까 do try catch로 받기
                
            } catch {
                print("file remove error")
            }
        } else {
            print("file no exist, remove error")
        }
    }
}

