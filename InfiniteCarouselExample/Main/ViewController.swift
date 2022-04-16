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
    .init(imageURL: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.tabikobo.com%2Fspecial%2Fzekkei%2F&psig=AOvVaw20xgrMgDAKXcjjWGuHN9HO&ust=1650210345188000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCICIst32mPcCFQAAAAAdAAAAABAD"),
    .init(imageURL: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.jalan.net%2Fnews%2Farticle%2F219249%2F&psig=AOvVaw20xgrMgDAKXcjjWGuHN9HO&ust=1650210345188000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCICIst32mPcCFQAAAAAdAAAAABAI"),
    .init(imageURL: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.tabikobo.com%2Fspecial%2Fzekkei%2F&psig=AOvVaw20xgrMgDAKXcjjWGuHN9HO&ust=1650210345188000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCICIst32mPcCFQAAAAAdAAAAABAO"),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    let layout = CustomLayout()
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

