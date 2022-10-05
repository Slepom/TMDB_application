

import UIKit

class AuthenticationViewController: UIViewController {
    
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GettingData.shared.createListMovie()
        setupollectionView()
        
    }
    
    private func listSection() ->  UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: .fractionalHeight(1.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 4)
        //group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        group.interItemSpacing = .fixed(5)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func setupollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: listSection())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    
    
    
    
    
}

extension AuthenticationViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        cell.layer.borderWidth = 1
        return cell
    }
    
    
    
}
