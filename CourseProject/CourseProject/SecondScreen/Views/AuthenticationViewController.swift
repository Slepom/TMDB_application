

import UIKit

class AuthenticationViewController: UIViewController {
    
  
    typealias DataSourceTest = UICollectionViewDiffableDataSource<Genre, Result>
    var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Genre, Result>?
 
   
    var dictFinal: [Genre:[Result]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSourceTest()
       
        //!!!!!!!!!!
        GettingData.shared.finalTest({ [weak self] arrayResult in
            self?.dictFinal = arrayResult
            self?.reloadDataSectionsTest()
        })
        

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
    

    
    func setupDataSourceTest(){
        dataSource = UICollectionViewDiffableDataSource<Genre, Result>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, result) -> UICollectionViewCell? in
         
            let section = Array(self.dictFinal.keys)[indexPath.section]
            switch section{
            default:
                return self.configure(cellType: UserCell.self, with: self.dictFinal[section]![indexPath.item], for: indexPath)
            }
       
        })
       

        }
        
        
        
    
    
    func reloadDataSectionsTest(){
        var snapshots = NSDiffableDataSourceSnapshot<Genre, Result>()
        
        let arrayGenre = Array(dictFinal.keys)
        snapshots.appendSections(arrayGenre)
     
        
        for genre in arrayGenre{
            snapshots.appendItems(dictFinal[genre]!, toSection: genre)
            
        }
        dataSource?.apply(snapshots,animatingDifferences: true)
    }
    

    
    
    
    func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
           
            let section = Array(self.dictFinal)[sectionIndex]
            return self.createFeaturedSection(using: section.key)
            
//            switch section.key{
//
//            default:
//                return self.createFeaturedSection(using: section.key)
//            }
            
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
        
    }
    
    
    
    
    
    func createFeaturedSection(using section: Genre) -> NSCollectionLayoutSection{

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
   
    }
       

}
