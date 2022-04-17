//
//  ViewController.swift
//  InfiniteCarouselExample
//
//  Created by Toshiharu Imaeda on 2022/04/16.
//

import UIKit

struct Item {
  var imageURL: String
}

class ViewController: UIViewController {
  private let collectionViewHeight: CGFloat = 200
  private var collectionView: UICollectionView!
  private let cellName = "Cell"

  private var data: [Item] = [
    .init(imageURL: "https://www.tabikobo.com/special/zekkei/images/main.jpg"),
    .init(imageURL: "https://www.tabikobo.com/special/zekkei/images/canada03.jpg"),
    .init(imageURL: "https://www.jalan.net/news/img/2021/04/20210402_zekkei_030-670x443.jpg"),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    let layout = CustomLayout(delegate: self)
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = .secondarySystemBackground
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
    ])

    collectionView.register(.init(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: cellName)
    collectionView.dataSource = self
    collectionView.reloadData()
  }
  
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    data.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! CustomCell
    cell.configure(url: data[indexPath.row].imageURL)
    return cell
  }
}

extension ViewController: CustomLayoutDelegate {
}
