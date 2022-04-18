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
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var positionViewHeight: NSLayoutConstraint!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!

  private var collectionView: UICollectionView!
  private let cellName = "Cell"
  private let refreshControl = CustomRefreshControl()

  private var data: [Item] = [
    .init(imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0M0nxkQHf_JI4IRgd1_gV-VO02Xsx3IJeQA&usqp=CAU"),
    .init(imageURL: "https://1.bp.blogspot.com/-xnNU3RpKFc0/XtD_BJLtXkI/AAAAAAAAB4o/qyyGBKoMRcEBQb3dsfrfbQY5hU7j9Q_fwCLcBGAsYHQ/s1600/16-9.jpg"),
    .init(imageURL: "https://st.depositphotos.com/2012555/1934/i/950/depositphotos_19342771-stock-photo-winter-landscape-with-little-house.jpg"),
    .init(imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0M0nxkQHf_JI4IRgd1_gV-VO02Xsx3IJeQA&usqp=CAU"),
    .init(imageURL: "https://1.bp.blogspot.com/-xnNU3RpKFc0/XtD_BJLtXkI/AAAAAAAAB4o/qyyGBKoMRcEBQb3dsfrfbQY5hU7j9Q_fwCLcBGAsYHQ/s1600/16-9.jpg"),
    .init(imageURL: "https://st.depositphotos.com/2012555/1934/i/950/depositphotos_19342771-stock-photo-winter-landscape-with-little-house.jpg"),
    .init(imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0M0nxkQHf_JI4IRgd1_gV-VO02Xsx3IJeQA&usqp=CAU"),
    .init(imageURL: "https://1.bp.blogspot.com/-xnNU3RpKFc0/XtD_BJLtXkI/AAAAAAAAB4o/qyyGBKoMRcEBQb3dsfrfbQY5hU7j9Q_fwCLcBGAsYHQ/s1600/16-9.jpg"),
    .init(imageURL: "https://st.depositphotos.com/2012555/1934/i/950/depositphotos_19342771-stock-photo-winter-landscape-with-little-house.jpg"),
  ]

  @IBAction func didTapPageControl(_ sender: UIPageControl) {
    let indexPath = IndexPath(row: sender.currentPage, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    coordinator.animate(alongsideTransition: nil, completion: { [weak self] _ in
      guard let self = self, let layout = self.collectionView.collectionViewLayout as? CustomLayout,
            let index = layout.currentIndex else {
        return
      }
      self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    })
  }

  private func setup() {
    pageControl.numberOfPages = data.count

    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CustomLayout(delegate: self))
    collectionView.backgroundColor = .secondarySystemBackground
    collectionView.decelerationRate = .fast
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])

    collectionView.register(.init(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: cellName)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.reloadData()

    scrollView.delegate = self
    scrollView.refreshControl = refreshControl

    refreshControl.addTarget(self, action: #selector(refreshControl(_:)), for: .valueChanged)
    refreshControl.tintColor = .gray
    scrollView.bringSubviewToFront(refreshControl)
  }

  @objc private func refreshControl(_ sender: UIRefreshControl) {
    refreshControl.endRefreshing()
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

extension ViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.tag == 1 {
      // CollectionView内のScrollViewではない
    } else {
      // CollectionView内のScrollView
      guard scrollView.tag != 1,
            let layout = collectionView.collectionViewLayout as? CustomLayout,
            let index = layout.currentIndex else {
        return
      }
      pageControl.currentPage = index
    }
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView.tag == 1 {
      // CollectionView内のScrollViewではない
    } else {
      // CollectionView内のScrollView
    }
  }
}

extension ViewController: CustomLayoutDelegate {
  var parentScrollViewContentOffsetY: CGFloat {
    scrollView.contentOffset.y
  }
}
