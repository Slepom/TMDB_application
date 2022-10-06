

import Foundation
import UIKit

protocol SelfConfiguringCell{
    static var reuseId: String {get}
    func configure(with intValue: Int)

}
