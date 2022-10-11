

import UIKit

class AuthenticationViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<MovieModel, Result>!

    var collectionView: UICollectionView!
    
    var sections: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSourceData()
        GettingData.shared.createListMovie { [weak self] dataMovieModel in
            self?.sections = [dataMovieModel]
            self?.reloadDataSections()

        }
    
      
    }
    func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        //collectionView.register(UserCellSecond.self, forCellWithReuseIdentifier: UserCellSecond.reuseId)
        //setupDataSourceData()
        //reloadDataSections()
        view.addSubview(collectionView)
    }
        
    func configure<T:SelfConfiguringCell>(cellType: T.Type, with result: Result, for indexPath: IndexPath)->T{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else{
            fatalError("Unable to dequeu \(cellType)")
        }
        cell.configure(with: result)
        return cell
    }
    
    func setupDataSourceData(){
        dataSource = UICollectionViewDiffableDataSource<MovieModel, Result>(collectionView: collectionView)
        { (collectionView, indexPath, result) -> UICollectionViewCell? in
            switch self.sections[indexPath.section].page{
            default:
                return self.configure(cellType: UserCell.self, with: result, for: indexPath)
            }
        }
    }
    func reloadDataSections(){
        var snapshots = NSDiffableDataSourceSnapshot<MovieModel, Result>()
        snapshots.appendSections(sections)
        for section in sections {
            snapshots.appendItems(section.results, toSection: section)
        }
        dataSource.apply(snapshots)
    }


    
    
     func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]

            switch section.page{
            default:
               return self.createFeaturedSection(using: section)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    
      
    
    
 
    
     func createFeaturedSection(using section: MovieModel) -> NSCollectionLayoutSection{
        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1))
//
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
//         layoutGroup.interItemSpacing = .fixed(CGFloat(10))
//        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
         //layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
         
         
         
         
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
        return section
        
        
        
        
        
        
        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
//        let spacing = CGFloat(10)
//
//        group.interItemSpacing = .fixed(spacing)
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = spacing
//        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10)
//       section.orthogonalScrollingBehavior = .continuous
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        //config.interSectionSpacing = 30
//        layout.configuration = config
//
        
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
