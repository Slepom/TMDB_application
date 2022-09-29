

import Foundation

class BindingButton<T> {
    typealias Listner = (T) -> Void
    private var listner: Listner?
    
    func bind(_ listner: Listner?){
        self.listner = listner
    }
    
    var newValue: T{
        didSet{
            listner?(newValue)
        }
    }
    init (_ newValue: T){
        self.newValue = newValue
    }
}
