//
//  CardVC.swift
//  Alamofire
//
//  Created by 朱杰 on 2021/10/22.
//

import Foundation

class CardVC: UIViewController {
    private let provider = MoyaProvider<Imgur>()
    private var uploadedCard: Card?
    
    var uploadCardBtn = UIButton.init()
    var deleteCardBtn = UIButton.init()
    var progressBar = UIProgressView.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.uploadCardBtn)
        self.view.addSubview(self.deleteCardBtn)
        self.view.addSubview(self.progressBar)
        
        self.uploadCardBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(200)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(50)
        }
        
        self.deleteCardBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(300)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(50)
        }
        
        self.progressBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(400)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(10)
        }
        
        
        self.uploadCardBtn.backgroundColor = .red
        self.deleteCardBtn.backgroundColor = .red
        self.uploadCardBtn.setTitle("提交", for: .normal)
        self.deleteCardBtn.setTitle("删除", for: .normal)
        self.uploadCardBtn.addTarget(self, action: #selector(uploadCard), for: .touchUpInside)
        self.deleteCardBtn.addTarget(self, action: #selector(deleteCard), for: .touchUpInside)
        self.progressBar.tintColor = .blue
    }
    
    @objc private func uploadCard() {
        let card = snapCard()
        provider.request(.upload(card), callbackQueue: DispatchQueue.main) { [weak self] progress in
            self?.progressBar.setProgress(Float(progress.progress), animated: true)
        } completion: { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
              do {
                let upload = try result.map(ImgurResponse<Card>.self)
                
                self.uploadedCard = upload.data
                self.presentShare(image: card, url: upload.data.link)
              } catch {
                self.presentError()
              }
            case .failure:
              self.presentError()
            }
        }

    }
    
    @objc private func deleteCard() {
        guard let uploadCard = uploadedCard else { return }
        provider.request(.delete(uploadCard.deletehash)) { [weak self] response in
            guard let self = self else { return }
            let message: String
            switch response {
            case .success:
                message = "Deleted successfully!"
            case .failure:
                message = "Failed deleting card! Try again later."
            }
            
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel))

            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
    
// MARK: - Helpers
extension CardVC {
    //成功弹窗
    private func presentShare(image: UIImage, url: URL) {
      let alert = UIAlertController(title: "Your card is ready!", message: nil, preferredStyle: .actionSheet)

      let openAction = UIAlertAction(title: "Open in Imgur", style: .default) { _ in
        UIApplication.shared.open(url)
      }

      let shareAction = UIAlertAction(title: "Share", style: .default) { [weak self] _ in
        let share = UIActivityViewController(activityItems: ["Check out my iMarvel card!", url, image],
                                             applicationActivities: nil)
        share.excludedActivityTypes = [.airDrop, .addToReadingList]
        self?.present(share, animated: true, completion: nil)
      }

      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

      alert.addAction(openAction)
      alert.addAction(shareAction)
      alert.addAction(cancelAction)

      present(alert, animated: true, completion: nil)
    }
    //错误打印
    private func presentError() {
      let alert = UIAlertController(title: "Uh oh", message: "Something went wrong. Try again later.",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

      present(alert, animated: true, completion: nil)
    }
    //截取self.view作为image
    private func snapCard() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, UIScreen.main.scale)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
      guard let image = UIGraphicsGetImageFromCurrentImageContext() else { fatalError("Failed snapping card") }
      UIGraphicsEndImageContext()

      return image
    }
}
    

