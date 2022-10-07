

import UIKit

class AuthenticationViewController: UIViewController {
    
    
    var collectionView: UICollectionView!
    
    enum SectionKind: Int, CaseIterable{
        case list, grid
    }
    
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GettingData.shared.createListMovie()
        setupCollectionView()
        
    }
    
  
    func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(NextCell.self, forCellWithReuseIdentifier: NextCell.reuseId)
        setupDataSource()
        reloadData()
        view.addSubview(collectionView)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
    }
    
    func configure<T:SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath)->T{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else{
            return fatalError("Error \(cellType)") as! T}
        return cell
    }
    
    
    
    
    
    
    
   private func setupDataSource(){
       dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, intValue)->UICollectionViewCell?  in
           let section = SectionKind(rawValue: indexPath.section)!
           switch section {

           case .list:
               return self.configure(cellType: UserCell.self, with: intValue, for: indexPath)
           case .grid:
               return self.configure(cellType: NextCell.self, with: intValue, for: indexPath)
           }
      
       })
    }
    
    func reloadData(){
       var snapShot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        SectionKind.allCases.forEach { sectionKind in
            snapShot.appendSections([sectionKind])
            snapShot.appendItems([1,2,3,4,5,6,7,8,9], toSection: sectionKind)
        }
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    
    
    
    
    
    
  
    }

//extension AuthenticationViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 24
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .blue
//        return cell
//    }
//    
//    
//}

extension AuthenticationViewController{
    
    private func createLayout() -> UICollectionViewLayout{
        
t
//
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(20)
        
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: spacing, bottom: 0, trailing: spacing)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
  
}




//
//import SwiftUI
//
//struct FlowProvider: PreviewProvider{
//    static var previews: some View{
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//    struct ContainerView: UIViewControllerRepresentable{
//
//        let tabBar = MainTabBarContreller
//    }
//
//}
}
