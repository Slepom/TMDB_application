
import UIKit

protocol CompositionalLayoutProtocol {
    
    var title: String { get }
    var subtitle: String? { get }
    
    var numberOfSections: Int { get }
    var numberOfRowsPerSection: Int { get }
    
    func create() -> UICollectionViewLayout
    
}

extension CompositionalLayoutProtocol {

    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRowsPerSection: Int {
        return 40
    }

}

