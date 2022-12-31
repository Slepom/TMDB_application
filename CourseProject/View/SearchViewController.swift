
import UIKit

class SearchViewController: UIViewController {

    var arrayOfMovie = [MoviesByGenre]()
    var arrayPopularMovie = [MoviesByGenre]()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Hello World"
        return label
    }()
    
    lazy var collectionSearch: UICollectionView = {
        let collectionSearch = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        //collectionSearch.collectionViewLayout = createCompositionalLayout()
        collectionSearch.translatesAutoresizingMaskIntoConstraints = false
        return collectionSearch
    }()
    
    private var searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Enter the movie name"
        sb.searchBar.searchBarStyle = .minimal
        sb.tabBarItem.badgeColor = .black
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getPopularMovie { arrayOfMovie in
            self.arrayPopularMovie = arrayOfMovie
            self.collectionSearch.reloadData()
        }
        
        
        
        navigationItem.title  = "Search"
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchBar
        definesPresentationContext = true
        //view.addSubview(label)
        label.frame = CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
        
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            collectionSearch.topAnchor.constraint(equalTo: view.topAnchor),
            collectionSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionSearch.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionView(){
        
        //collectionSearch.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionSearch.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.reuseId)
        collectionSearch.dataSource = self
        collectionSearch.delegate = self
        collectionSearch.backgroundColor = .black
        view.addSubview(collectionSearch)
    }
  
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }




}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {return}
        
        if query.isEmpty{
            self.arrayOfMovie.removeAll()
            self.collectionSearch.reloadData()
        }
       
            
            searchController.showsSearchResultsController =  true
            
            SearchRequest.shared.search(with:query.trimmingCharacters(in: .whitespaces)) { [weak self] movie in
                guard let self = self else {return}
                
                self.arrayOfMovie = movie
                
                DispatchQueue.main.async {
                    self.collectionSearch.reloadData()
                }
            }
        
       
    }
    
   
    
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.searchBar.isActive{
        case true: return self.arrayOfMovie.count
        case false: return self.arrayPopularMovie.count
        }
        
        
       // self.arrayOfMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var movie: MoviesByGenre!
        switch self.searchBar.isActive{
        case true: movie = self.arrayOfMovie[indexPath.row]
        case false: movie = self.arrayPopularMovie[indexPath.row]
        }
       // let movie = self.arrayOfMovie[indexPath.row]
        
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCell.reuseId, for: indexPath) as? SearchViewCell else {return UICollectionViewCell()}
        cell.configure(with: movie)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var movie: MoviesByGenre!
        switch self.searchBar.isActive{
        case true: movie = self.arrayOfMovie[indexPath.row]
        case false: movie = self.arrayPopularMovie[indexPath.row]
        }
        
        
        
       // let movie = self.arrayOfMovie[indexPath.row]
        
        let vc = DetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.movieByGenre = movie
        vc.configureByMovie(with: movie)
        vc.modalPresentationStyle = .fullScreen

    }
    
    
}
