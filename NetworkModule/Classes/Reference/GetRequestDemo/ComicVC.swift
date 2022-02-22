//
//  ComicVC.swift
//  NetworkModule
//
//  Created by 朱杰 on 2021/10/16.
//

import Foundation

class ComicVC: UIViewController {
    let provider = MoyaProvider<Marvel>()
    
    // MARK: - View State
    private var state: State = .loading {
      didSet {
        switch state {
        case .ready:
            requestView.isHidden = true
            tbvComic.isHidden = false
            tbvComic.reloadData()
        case .loading:
            tbvComic.isHidden = true
            requestView.isHidden = false
            requestMessage.text = "Getting comics ..."
            requestImageView.image = UIImage.init(named: "loading img")
        case .error:
            tbvComic.isHidden = true
            requestView.isHidden = false
            requestMessage.text = """
                              Something went wrong!
                              Try again later.
                            """
            requestImageView.image = UIImage.init(named: "loaded error img")
        }
      }
    }
    
    
    var tbvComic = UITableView.init()
    var requestView = UIView.init()
    var requestImageView = UIImageView.init()
    var requestMessage = UILabel.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tbvComic)
        tbvComic.delegate = self
        tbvComic.dataSource = self
        tbvComic.register(cellType: ComicCell.self)
        
        self.view.addSubview(tbvComic)
        self.view.addSubview(requestView)
        requestView.addSubview(requestImageView)
        requestView.addSubview(requestMessage)
        
        tbvComic.snp.makeConstraints { make in
            make.edges.equalToSuperview();
        }
        requestView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(250)
            make.top.equalTo(self.view.snp.top).offset(200)
            make.centerX.equalToSuperview()
        }
        requestImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(200)
        }
        requestMessage.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.state = .loading
        self.view.backgroundColor = .white
        tbvComic.backgroundColor = .yellow
        requestView.backgroundColor = .white
        requestImageView.backgroundColor = .red
        requestMessage.textColor = .black
        
        provider.request(.comics) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    self.state = .ready(try response.map(MarvelResponse<Comic>.self).data.results)
                } catch {
                    self.state = .error
                }
            case .failure:
                self.state = .error
          }
        }
        
//        self.testDataSource()
    }
    
    func testDataSource() -> Void {
        let jsonDict = [
            "id":100100,
            "title": "Kody",
            "description": "Swift",
            "thumbnail":[
                "path": "https://pics1.baidu.com",
                "despath": "/feed/f9198618367adab450ba39e71893f9158601e4f8.jpeg?token=21222a7f8ba3dcf3701c6cf1bcff5952",
            ],
            "characters":[
                "available":200200,
                "items":[
                    ["name":"name1","resourceURL":"https://"],
                ]
            ]
        ] as [String : Any]

        let jsonData = (try? JSONSerialization.data(withJSONObject: jsonDict, options: [])) ?? "".data(using: .utf8)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        let json = (jsonString?.data(using: .utf8))!

        let decoder = JSONDecoder()
        let c = try? decoder.decode(Comic.self, from: json)
        print(c ?? "")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = .ready([c!])
        }
    }
}



extension ComicVC {
    enum State {
    case loading
    case ready([Comic])
    case error
    }
}

// MARK: - UITableView Delegate & Data Source
extension ComicVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as ComicCell

    guard case .ready(let items) = state else { return cell }

    cell.configureWith(items[indexPath.item])

    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard case .ready(let items) = state else { return 0 }

    return items.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)

//    guard case .ready(let items) = state else { return }
    
  }
}
