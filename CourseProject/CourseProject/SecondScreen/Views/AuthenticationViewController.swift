

import UIKit

class AuthenticationViewController: UIViewController {
    
    //var dataSource: UICollectionViewDiffableDataSource<MovieModel, Result>!
    //var dataSourceGenre: UICollectionViewDiffableDataSource<GenreModel, Genre>!
    var dataSourceTest: UICollectionViewDiffableDataSource<Genre, Result>!
    var collectionView: UICollectionView!
    
    //var sections: [MovieModel] = []
    
    var arrayGenre: [Genre] = []

    var arrayResult: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        //setupDataSourceData()
//        GettingData.shared.createListMovie { [weak self] dataMovieModel in
//            self?.sections = [dataMovieModel]
//            self?.reloadDataSections()
//        }
        setupDataSourceTest()
        GettingData.shared.getGenres { [weak self] dataGenreModel in
            self?.arrayGenre = dataGenreModel

        }
        GettingData.shared.createResulTest { [weak self] dataResult in
            self?.arrayResult = dataResult
            self?.reloadDataSectionsTest()
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
    
//    func setupDataSourceData(){
//        dataSource = UICollectionViewDiffableDataSource<MovieModel, Result>(collectionView: collectionView)
//        { (collectionView, indexPath, result) -> UICollectionViewCell? in
//            switch self.sections[indexPath.section].page{
//            default:
//                return self.configure(cellType: UserCell.self, with: result, for: indexPath)
//            }
//        }
//    }
    func setupDataSourceTest(){
        dataSourceTest = UICollectionViewDiffableDataSource<Genre, Result>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, result) -> UICollectionViewCell? in
            
            switch self.arrayGenre[indexPath.section].name{
            default:
                return self.configure(cellType: UserCell.self, with: result, for: indexPath)
            }
            
        })
        
        
    }
    func reloadDataSectionsTest(){
        var snapshots = NSDiffableDataSourceSnapshot<Genre, Result>()
        snapshots.appendSections(arrayGenre)
      
        snapshots.appendItems(arrayResult, toSection: arrayGenre.first)

        dataSourceTest.apply(snapshots)
    }

    
    
    
    
//    func reloadDataSections(){
//        var snapshots = NSDiffableDataSourceSnapshot<MovieModel, Result>()
//        snapshots.appendSections(sections)
//        for section in sections {
//            snapshots.appendItems(section.results, toSection: section)
//        }
//        dataSource.apply(snapshots)
//    }

//    func reloadDataGenre(){
//        var snapshots = NSDiffableDataSourceSnapshot<GenreModel, Genre>()
//        snapshots.appendSections(genre)
//        for section in genre {
//            snapshots.appendItems(section.genres, toSection: section)
//        }
//        dataSourceGenre.apply(snapshots)
//    }
    
    
    

    
    
     func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            //let section = self.sections[sectionIndex]
//
            let section = self.arrayGenre[sectionIndex]
            let result = self.arrayResult[sectionIndex]
            switch section.id{
            default:
            return self.createFeaturedSection(using: result)
            }
            
            

            
//            switch section.results.first{
//            default:
//               return self.createFeaturedSection(using: section)
//            }
//        }
       
    }
         let config = UICollectionViewCompositionalLayoutConfiguration()
         config.interSectionSpacing = 20
         layout.configuration = config
         return layout
    
     }
      
    
    
 
    
     func createFeaturedSection(using section: Result) -> NSCollectionLayoutSection{
        

         
         
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


