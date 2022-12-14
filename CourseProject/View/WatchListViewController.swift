

import UIKit

class WatchListViewController: UIViewController {
    
    var watchlist = [MoviesByGenre]()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Watchlist"
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WatchListCell.self, forCellReuseIdentifier: WatchListCell.identifier)
        
    }
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           setupConstraints()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WatchListRequest.shared.getWatchlist(accountId: globalValueIdAccount, sessionId: globalValueSessionId) { movies in
            self.watchlist = movies.reversed()
            self.tableView.reloadData()
        }
    }
    private func setupConstraints() {
          view.addSubview(tableView)
          NSLayoutConstraint.activate([
              tableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
              tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
              tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
              tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
          ])
      }
      
    
    
}
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListCell.identifier) as? WatchListCell else { return UITableViewCell() }
        cell.configure(media: self.watchlist[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          view.frame.width * 0.3 + 16
      }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeCell = UIContextualAction(style: .normal, title: "Remove") {[weak self] _,_,_ in
            guard let self = self else {return}
            WatchListRequest.shared.removeMoviewFromWatchlist(accountID: globalValueIdAccount, mediaType: "movie", mediaId: self.watchlist[indexPath.row].id , sessionId: globalValueSessionId) { result, media in
                
                self.watchlist.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            
        }
        

        removeCell.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [removeCell])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.watchlist[indexPath.row]
        
        let vc = DetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.movieByGenre = movie
        vc.configureByMovie(with: movie)
        vc.modalPresentationStyle = .fullScreen
    }
    
}
