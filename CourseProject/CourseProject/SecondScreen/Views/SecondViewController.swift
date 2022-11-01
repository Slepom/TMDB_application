
import UIKit

class SecondViewController: UIViewController {

    var collectionViewMovies: UICollectionView!

    var genreByResult: [String:[MoviesByGenre]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupCollectionView()
        GettingData.shared.finalTest { dictionary in
            self.genreByResult = dictionary
            self.collectionViewMovies.reloadData()
        }
    }

    
    private func setupCollectionView(){
        collectionViewMovies = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionViewMovies.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewMovies.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        collectionViewMovies.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        view.addSubview(collectionViewMovies)
    }
    private func configure<T:SelfConfiguringCell>(cellType: T.Type, with result: MoviesByGenre, for indexPath: IndexPath)->T{
        guard let cell = collectionViewMovies.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else{
            fatalError("Unable to dequeu \(cellType)")
        }
        cell.configure(with: result)
        return cell
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 8
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(175), heightDimension: .absolute(285))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    

}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.genreByResult.keys.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.genreByResult.values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let key = Array(self.genreByResult.keys).sorted(by: <)[indexPath.section]
        let value = self.genreByResult[key]![indexPath.row]
        
        return configure(cellType: UserCell.self, with: value, for: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as! SectionHeader
        header.title.text = Array(self.genreByResult.keys).sorted(by: <)[indexPath.section]
        return header
    }
    
    
    
    
    
    
    
}
