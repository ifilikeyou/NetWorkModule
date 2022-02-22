//
//  ComicCell.swift
//  NetworkModule
//
//  Created by 朱杰 on 2021/10/16.
//

import Foundation

class ComicCell: UITableViewCell, Reusable{
  public static let reuseIdentifier = "ComicCell"
    
    var title = UILabel.init()
    var desc = UILabel.init()
    var imgThumb = UIImageView.init()
    
    public func configureWith(_ comic: Comic) {
      title.text = comic.title
      desc.text = comic.description ?? "No description available"

      imgThumb.kf.setImage(with: comic.thumbnail.url,options: [.transition(.fade(0.3))])
    }
    func setupUI() -> Void {
        self.addSubview(imgThumb)
        self.addSubview(title)
        self.addSubview(desc)
        
        imgThumb.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(15)
            make.bottom.equalTo(self.snp.bottom).offset(-10);
            make.height.equalTo(imgThumb.snp.width)
        }
        title.snp.makeConstraints { make in
            make.left.equalTo(imgThumb.snp.right).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(20)
        }
        desc.snp.makeConstraints { make in
            make.left.equalTo(imgThumb.snp.right).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.height.equalTo(20)
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
