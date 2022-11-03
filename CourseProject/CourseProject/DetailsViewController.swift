//
//  DetailsViewController.swift
//  CourseProject
//
//  Created by Полина Жарова on 3.11.22.
//

import UIKit
import youtube_ios_player_helper
class DetailsViewController: UIViewController {

   lazy var collectionViewTrailer = UICollectionView()
    var arrayOfVideo = [Video]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        view.backgroundColor = .blue
        
    }
    
    func configureByMovie(with movie: MoviesByGenre) {
        TrailerRequest.shared.loadTrailerForMovie(movieId: movie.id) { array in
            DispatchQueue.main.async {
                self.arrayOfVideo = array
                self.collectionViewTrailer.reloadData()
            }
        }
    }


    private func setupCollectionView(){
        collectionViewTrailer = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionViewTrailer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewTrailer.register(TrailerCollectionViewCell.self, forCellWithReuseIdentifier: TrailerCollectionViewCell.reuseId)
        collectionViewTrailer.dataSource = self
        collectionViewTrailer.delegate = self
        
        view.addSubview(collectionViewTrailer)
    }
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 0
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(view.frame.size.width / 1.77))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arrayOfVideo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrailerCollectionViewCell", for: indexPath) as? TrailerCollectionViewCell else { return UICollectionViewCell() }
      cell.youtubePlayer.load(withVideoId: self.arrayOfVideo[indexPath.row].key)
        return cell
    }


}
