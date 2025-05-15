import SwiftUI
import TUIComponents

extension GalleryListLayout {
  struct ImageWrapper: View {
    let imageUrl: URL?
    let onLoadError: () -> Void

    var body: some View {
      Rectangle()
        .foregroundStyle(.clear)
        .overlay {
          RemoteImage(
            url: imageUrl,
            config: RemoteImage.Config(
              analyticsCallbacks: RemoteImage.AnalyticsCallbacks(
                onLoadError: onLoadError
              )
            )
          )
        }
        .clipped()
        .transition(.asymmetric(insertion: .opacity, removal: .identity))
    }
  }
}
