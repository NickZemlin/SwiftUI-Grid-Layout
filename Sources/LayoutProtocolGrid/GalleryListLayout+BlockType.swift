import SwiftUI

enum BlockType {
  case leadingFullWidth(subview: LayoutSubview)
  case trailingFullWidth(subview: LayoutSubview)
  case tallHalfWidth(subview: LayoutSubview, column: BlockColumn)
  case shortHalfWidth(subview: LayoutSubview, column: BlockColumn, height: CGFloat)

  var subview: LayoutSubview {
    switch self {
    case let .leadingFullWidth(subview),
         let .trailingFullWidth(subview),
         let .tallHalfWidth(subview, _),
         let .shortHalfWidth(subview, _, _):
      subview
    }
  }

  func getPosition(
    bounds: CGRect,
    currentY: CGFloat,
    columnOffset: CGFloat = .zero
  ) -> CGPoint {
    switch self {
    case .leadingFullWidth, .trailingFullWidth:
      CGPoint(x: bounds.minX, y: currentY)
    case let .tallHalfWidth(_, column), let .shortHalfWidth(_, column, _):
      CGPoint(x: column.getXPosition(bounds: bounds), y: currentY)
    }
  }

  func getProposalViewSize(bounds: CGRect) -> ProposedViewSize {
    switch self {
    case .leadingFullWidth:
      ProposedViewSize(width: bounds.width, height: GalleryListLayout.Sizes.imageHeight)
    case .trailingFullWidth:
      ProposedViewSize(width: bounds.width, height: GalleryListLayout.Sizes.mediumImageHeight)
    case let .tallHalfWidth(_, column):
      ProposedViewSize(width: column.width, height: GalleryListLayout.Sizes.imageHeight)
    case let .shortHalfWidth(_, column, height):
      ProposedViewSize(width: column.width, height: height)
    }
  }

  var subViewHeight: CGFloat {
    switch self {
    case .leadingFullWidth:
      GalleryListLayout.Sizes.imageHeight
    case .trailingFullWidth:
      GalleryListLayout.Sizes.mediumImageHeight
    case .tallHalfWidth:
      GalleryListLayout.Sizes.imageHeight
    case let .shortHalfWidth(_, _, height):
      height
    }
  }
}

extension BlockType {
  enum BlockColumn {
    case left(width: CGFloat)
    case right(width: CGFloat, offset: CGFloat)

    func getXPosition(bounds: CGRect) -> CGFloat {
      switch self {
      case .left:
        bounds.minX
      case let .right(_, offset):
        bounds.minX + offset
      }
    }

    var width: CGFloat {
      switch self {
      case let .left(columnWidth), let .right(columnWidth, _):
        columnWidth
      }
    }
  }
}
