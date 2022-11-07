//
//  DetailsViewController.swift
//  CourseProject
//
//  Created by Полина Жарова on 3.11.22.
//

import UIKit
import youtube_ios_player_helper
class DetailsViewController: UIViewController {

    var movieByGenre: MoviesByGenre!
    var name: String!
    var releaseDate: String!
    var genre = UILabel()
    
   lazy var collectionViewTrailer = UICollectionView()
    var arrayOfVideo = [Video]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        view.backgroundColor = .blue
        //navigationItem.title = self.name
    }
    

    
    
    func configureByMovie(with movie: MoviesByGenre) {
        TrailerRequest.shared.loadTrailerForMovie(movieId: movie.id) { array in
            DispatchQueue.main.async {
                self.arrayOfVideo = array
                self.collectionViewTrailer.reloadData()
            }
        }
        self.navigationItem.title = movie.title
        //print(movie)
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
       // let spacing: CGFloat = 0
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
                .estimated(400))
               // .absolute(view.frame.size.width * 1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .paging
        let layout = UICollectionViewCompositionalLayout(section: section)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
}
extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arrayOfVideo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrailerCollectionViewCell", for: indexPath) as? TrailerCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: self.movieByGenre)
        cell.youtubePlayer.load(withVideoId: self.arrayOfVideo[indexPath.item].key)
        return cell
    }


}
