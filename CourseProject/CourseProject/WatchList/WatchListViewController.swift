

import UIKit

class WatchListViewController: UIViewController {

    var watchlist = [MoviesByGenre]()
        
        
        private lazy var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.tableFooterView = UIView() // hide extra separator
            tableView.keyboardDismissMode = .onDrag
            return tableView
        }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Watchlist"
                
                view.addSubview(tableView)
                tableView.frame = view.bounds
                
                tableView.delegate = self
                tableView.dataSource = self
                
                tableView.register(WatchListCell.self, forCellReuseIdentifier: WatchListCell.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        WatchListRequest.shared.getWatchlist(accountId: globalValueIdAccount, sessionId: globalValueSessionId) { movies in
               self.watchlist = movies
               self.tableView.reloadData()
           }
       }
    

}
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListCell.identifier) as? WatchListCell else { return UITableViewCell() }
        //        cell.configure(media: viewModel.arrayOfMoviesWatchlist[indexPath.row])
                cell.configure(media: watchlist[indexPath.row])
                //        let cell = UITableViewCell()
                //        cell.textLabel?.text = arrayOfNumbers[indexPath.row]
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            130
        }
    
    
}
