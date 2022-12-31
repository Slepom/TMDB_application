//
//  DetailsViewController.swift
//  CourseProject
//
//  Created by Полина Жарова on 3.11.22.
//

import UIKit
import youtube_ios_player_helper
class DetailsViewController: UIViewController {

    var videoCollectionView: UICollectionView!
    var arrayOfVideo: [Video]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    

    
    
    
    
    
    
    
    private func setupCollectionView(){
        videoCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        videoCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoCollectionView.register(UserCell.self, forCellWithReuseIdentifier: TrailerViewCell.reuseId)
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        view.addSubview(videoCollectionView)
    }
    
    private func configure<T:SelfConfiguringCell>(cellType: T.Type, with result: MoviesByGenre, for indexPath: IndexPath)->T{
        guard let cell = collectionViewMovies.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else{
            fatalError("Unable to dequeu \(cellType)")
        }
        cell.youtubePlayer.load(withVideoId: self.arrayOfVideo[indexPath.row].key)
        cell.configure(with: result)
        return cell
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

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count =  self.arrayOfVideo.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let value = self.arrayOfVideo[indexPath.row]
        configure(cellType: TrailerViewCell.self, with: value , for: indexPath)
    }
    
}
