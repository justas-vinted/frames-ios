import UIKit

public protocol ElementStyle {
    var isHidden: Bool { get set }
    var text: String { get set }
    var font: UIFont { get set }
    var backgroundColor: UIColor { get set }
    var textColor: UIColor { get set }
}
