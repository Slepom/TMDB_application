

import UIKit

class AuthenticationViewController: UIViewController {
    
    
    var collectionView: UICollectionView!
    
    var sections: [Result] = [] {
        didSet {
            print(sections)
        }
    }
  
    var dataSourceNext: UICollectionViewDiffableDataSource<MovieModel, Result>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
       // print(sections)
        GettingData.shared.createListMovie { value in
            self.sections = value
        }
        //print(sections)
    }
    
    
    func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        //collectionView.register(UserCellSecond.self, forCellWithReuseIdentifier: UserCellSecond.reuseId)
//        setupDataSourceData()
//        reloadDataSections()
        view.addSubview(collectionView)
    
    }
    
    
    func configure<T:SelfConfiguringCell>(cellType: T.Type, with result: Result, for indexPath: IndexPath)->T{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else{
            fatalError("Unable to dequeu \(cellType)")
        }
        cell.configure(with: result)
        return cell
    }
    

//    private func setupDataSourceData(){
//        dataSourceNext = UICollectionViewDiffableDataSource<MovieModel, Result>(collectionView: collectionView)
//        { (collectionView, indexPath, result) -> UICollectionViewCell? in
//            switch self.sections[indexPath.section].results.first?.genreIDS{
//            default:
//                return self.configure(cellType: UserCell.self, with: result, for: indexPath)
//            }
//        }
//    }
    
    
    
//    func reloadDataSections(){
//        var snapshots = NSDiffableDataSourceSnapshot<MovieModel, Result>()
//        snapshots.appendSections(sections)
//        for section in sections {
//            snapshots.appendItems(section.results, toSection: section)
//        }
//        dataSourceNext.apply(snapshots)
//    }
//

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func createLayout() -> UICollectionViewLayout{
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let spacing = CGFloat(10)
        
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10)
       section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        //config.interSectionSpacing = 30
        layout.configuration = config
        
        return layout
        
    }
    
    
    
    
    
    
}



extension AuthenticationViewController{
    
    //    private func createLayout() -> UICollectionViewLayout{
    //
    //
    ////
    //        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    //
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
    //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    //        let spacing = CGFloat(20)
    //
    //        group.interItemSpacing = .fixed(spacing)
    //        let section = NSCollectionLayoutSection(group: group)
    //        section.interGroupSpacing = spacing
    //        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: spacing, bottom: 0, trailing: spacing)
    //        let layout = UICollectionViewCompositionalLayout(section: section)
    //
    //        return layout
    //
    //}
    

}
