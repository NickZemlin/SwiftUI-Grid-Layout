import SwiftUI

extension GalleryListLayout {
  var animatableData: AnimatablePair<CGFloat, CGFloat> {
    get { AnimatablePair(CGFloat(subviewsCount), spacing) }
    set {
      subviewsCount = Int(newValue.first)
      spacing = newValue.second
    }
  }
}
