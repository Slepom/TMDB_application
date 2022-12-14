
import UIKit

class AllMovieViewController: UIViewController {
    
    var collectionViewMovies: UICollectionView!
    
    var genreByResult: [String:[MoviesByGenre]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top 20 Movies by genres"
        setupCollectionView()
        
        
        // MARK: - Movie data request
        
        GettingData.shared.movieByGenres { [weak self] dictionary in
            guard let self = self else {return}
            self.genreByResult = dictionary
            self.collectionViewMovies.reloadData()
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style:.plain, target: self, action: #selector(self.signout))
    }
    
    // MARK: - Finish session & get to authentication VC
    
    @objc func signout(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "signIn") as? AuthenticationViewController else { print("signIn vc id not set"); return }
        self.view.window?.rootViewController = controller
        self.view.window?.window?.makeKeyAndVisible()
        NetworkManager.shared.deleteSession(sessionId: globalValueSessionId)
        
    }
    
    // MARK: - Setup collectionView
    
    private func setupCollectionView(){
        collectionViewMovies = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionViewMovies.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewMovies.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        collectionViewMovies.backgroundColor = .black
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
    
    // MARK: - Create collectionView Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 8
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(175),
            heightDimension: .absolute(285))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50.0))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    
    
    
}




extension AllMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate{
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let key = Array(self.genreByResult.keys).sorted(by: <)[indexPath.section]
        let movie = self.genreByResult[key]![indexPath.row]
        
        let vc = DetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.movieByGenre = movie
        vc.configureByMovie(with: movie)
        vc.modalPresentationStyle = .fullScreen
        
    }
    
    
    
    
}
