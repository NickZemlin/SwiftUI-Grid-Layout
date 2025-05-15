import SwiftUI

/**
  имплементация Layout протокола для расположение subViews по модульный сетке

  ``` swift
 GalleryListLayout {
   Rectange().repeating(12)
 }

 GalleryListLayout(spacing: 16) {
   Rectange().repeating(12)
 }
  ```

  - Parameters:
      - spacing: размер спейспинга

  > Tip:
  > Layout protocol не может задавать размеры subview
  > В SwiftUI Layout отдаёт дочерним View пропозал о свободном месте, и дочерние вью сами решают что с ним делать
  > В случае если нужно использовать изображения внутри ``GalleryListLayout`` рекомендуется использовать обёртку
  > ``` swift
  > GalleryListLayout {
  >    .Rectangle()
  >    .foregroundStyle(.clear)
  >    .overlay {
  >       RemoteImage(url: imageIndex)
  >    }
  >    .clipped()
  > }
  > ```

 */
struct GalleryListLayout: Layout {
  var spacing: CGFloat = Constants.defaultSpacing
  var subviewsCount: Int = .zero

  init(spacing: CGFloat = Constants.defaultSpacing) {
    self.spacing = spacing
  }

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    guard let availableWidth = proposal.width else { return .zero }

    let groupsCount = (subviews.count + Constants.maxImagesInOneBlock - 1) / Constants.maxImagesInOneBlock
    var totalHeight: CGFloat = .zero

    for group in 0..<groupsCount {
      let groupStartIndex = group * Constants.maxImagesInOneBlock
      let groupEndIndex = min((group + 1) * Constants.maxImagesInOneBlock, subviews.count)
      let groupSubviews = Array(subviews[groupStartIndex..<groupEndIndex])
      totalHeight += sizeOfGroup(subviews: groupSubviews, availableWidth: availableWidth).height
      if group < groupsCount - 1 {
        totalHeight += spacing
      }
    }

    return CGSize(width: availableWidth, height: totalHeight)
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    guard !subviews.isEmpty else { return }

    var currentY: CGFloat = bounds.minY

    let groupsCount = (subviews.count + Constants.maxImagesInOneBlock - 1) / Constants.maxImagesInOneBlock

    for group in .zero..<groupsCount {
      let groupStartIndex = group * Constants.maxImagesInOneBlock
      let groupEndIndex = min((group + 1) * Constants.maxImagesInOneBlock, subviews.count)
      let groupSubviews = Array(subviews[groupStartIndex..<groupEndIndex])
      placeGroup(
        in: CGRect(x: bounds.minX, y: currentY, width: bounds.width, height: bounds.height),
        subviews: groupSubviews
      )
      currentY += sizeOfGroup(subviews: groupSubviews, availableWidth: bounds.width).height + spacing
    }
  }
}

extension GalleryListLayout {
  enum Constants {
    static var maxImagesInOneBlock: Int { 6 }
    static var defaultSpacing: CGFloat { 8.0 }
  }

  enum Sizes {
    static var imageHeight: CGFloat { 260.0 }
    static var mediumImageHeight: CGFloat { 200.0 }
    static var doubleImageHeight: CGFloat { imageHeight * 2 }
    static var smallImageHeight: CGFloat { 126.0 }
  }
}
