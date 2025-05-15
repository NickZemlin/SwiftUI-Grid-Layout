import SwiftUI
import TRemoteAssert

extension GalleryListLayout {
  func sizeOfGroup(subviews: [LayoutSubview], availableWidth: CGFloat) -> CGSize {
    switch subviews.count {
    case 0:
      return .zero
    case 1:
      return CGSize(width: availableWidth, height: Sizes.imageHeight)
    case 3:
      return CGSize(width: availableWidth, height: (Sizes.imageHeight * 3) + (spacing * 3))
    case 2, 4:
      return CGSize(width: availableWidth, height: Sizes.doubleImageHeight + spacing)
    case 5:
      return CGSize(width: availableWidth, height: Sizes.doubleImageHeight + Sizes.smallImageHeight + spacing * 2)
    case 6:
      return CGSize(
        width: availableWidth,
        height: Sizes.doubleImageHeight + Sizes.smallImageHeight + Sizes.mediumImageHeight + spacing * 3
      )
    default:
      RemoteAssert.assertionFailure("Unsupported number of subviews")
      return .zero
    }
  }

  // swiftlint:disable function_body_length
  func placeGroup(in bounds: CGRect, subviews: [LayoutSubview]) {
    var currentY: CGFloat = bounds.minY
    let columnWidth: CGFloat = (bounds.width - spacing) / 2
    switch subviews.count {
    case 1:
      placeSubview(
        block: .leadingFullWidth(subview: subviews[0]),
        bounds: bounds,
        currentY: currentY
      )

    case 2:
      placeSubview(
        block: .leadingFullWidth(subview: subviews[0]),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .leadingFullWidth(subview: subviews[1]),
        bounds: bounds,
        currentY: currentY
      )

    case 3:
      placeSubview(
        block: .leadingFullWidth(subview: subviews[0]),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .leadingFullWidth(subview: subviews[1]),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .leadingFullWidth(subview: subviews[2]),
        bounds: bounds,
        currentY: currentY
      )

    case 4:
      placeSubview(
        block: .leadingFullWidth(subview: subviews[0]),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .tallHalfWidth(
          subview: subviews[1],
          column: .left(width: columnWidth)
        ),
        bounds: bounds,
        currentY: currentY
      )

      let rightSubviewHeight: CGFloat = (Sizes.imageHeight - spacing) / 2

      placeSubview(
        block: .shortHalfWidth(
          subview: subviews[2],
          column: .right(width: columnWidth, offset: columnWidth + spacing),
          height: rightSubviewHeight
        ),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .shortHalfWidth(
          subview: subviews[3],
          column: .right(width: columnWidth, offset: columnWidth + spacing),
          height: rightSubviewHeight
        ),
        bounds: bounds,
        currentY: currentY
      )

    case 5:
      placeSubview(
        block: .leadingFullWidth(subview: subviews[0]),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .tallHalfWidth(
          subview: subviews[1],
          column: .left(width: columnWidth)
        ),
        bounds: bounds,
        currentY: currentY
      )

      placeSubview(
        block: .shortHalfWidth(
          subview: subviews[2],
          column: .left(width: columnWidth),
          height: Sizes.smallImageHeight
        ),
        bounds: bounds,
        currentY: currentY + Sizes.imageHeight + spacing
      )

      placeSubview(
        block: .shortHalfWidth(
          subview: subviews[3],
          column: .right(width: columnWidth, offset: columnWidth + spacing),
          height: Sizes.smallImageHeight
        ),
        bounds: bounds,
        currentY: currentY
      )

      placeSubview(
        block: .tallHalfWidth(
          subview: subviews[4],
          column: .right(width: columnWidth, offset: columnWidth + spacing)
        ),
        bounds: bounds,
        currentY: currentY + Sizes.smallImageHeight + spacing
      )

    case 6:
      placeSubview(
        block: .leadingFullWidth(subview: subviews[0]),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .tallHalfWidth(
          subview: subviews[1],
          column: .left(width: columnWidth)
        ),
        bounds: bounds,
        currentY: currentY
      )

      placeSubview(
        block: .shortHalfWidth(
          subview: subviews[2],
          column: .left(width: columnWidth),
          height: Sizes.smallImageHeight
        ),
        bounds: bounds,
        currentY: currentY + Sizes.imageHeight + spacing
      )

      placeSubview(
        block: .shortHalfWidth(
          subview: subviews[3],
          column: .right(width: columnWidth, offset: columnWidth + spacing),
          height: Sizes.smallImageHeight
        ),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .tallHalfWidth(
          subview: subviews[4],
          column: .right(width: columnWidth, offset: columnWidth + spacing)
        ),
        bounds: bounds,
        currentY: currentY,
        afterPlacement: { subViewHeight in
          currentY += subViewHeight + spacing
        }
      )

      placeSubview(
        block: .trailingFullWidth(subview: subviews[5]),
        bounds: bounds,
        currentY: currentY
      )

    default:
      RemoteAssert.assertionFailure("Unsupported number of subviews")
    }
  }

  private func placeSubview(
    block: BlockType,
    bounds: CGRect,
    currentY: CGFloat,
    afterPlacement: ((_ size: CGFloat) -> Void)? = nil
  ) {
    block.subview.place(
      at: block.getPosition(bounds: bounds, currentY: currentY),
      proposal: block.getProposalViewSize(bounds: bounds)
    )
    afterPlacement?(block.subViewHeight)
  }
}
