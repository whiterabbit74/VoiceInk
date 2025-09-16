import SwiftUI
import AppKit

/// A reusable info tip component that displays helpful information in a popover
struct InfoTip: View {
    // Content configuration
    var title: String
    var message: String
    var learnMoreLink: URL?
    var learnMoreText: String = "Learn More"
    
    // Appearance customization
    var iconName: String = "info.circle.fill"
    var iconSize: Image.Scale = .medium
    var iconColor: Color = .primary
    var width: CGFloat = 300
    
    // State
    @State private var isShowingTip: Bool = false
    
    var body: some View {
        Image(systemName: iconName)
            .imageScale(iconSize)
            .foregroundColor(iconColor)
            .fontWeight(.semibold)
            .padding(5)
            .contentShape(Rectangle())
            .popover(isPresented: $isShowingTip) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.headline)
                    
                    Text(message)
                        .frame(width: width, alignment: .leading)
                        .padding(.bottom, learnMoreLink != nil ? 5 : 0)
                    
                    if let url = learnMoreLink {
                        Button(learnMoreText) {
                            NSWorkspace.shared.open(url)
                        }
                        .foregroundColor(.blue)  
                    }
                }
                .padding()
            }
            .onTapGesture {
                isShowingTip.toggle()
            }
    }
}

// MARK: - Convenience initializers

extension InfoTip {
    /// Creates an InfoTip with just title and message
    init(title: String, message: String) {
        self.title = title
        self.message = message
        self.learnMoreLink = nil
    }
    
    /// Creates an InfoTip with a learn more link
    init(title: String, message: String, learnMoreURL: String) {
        self.title = title
        self.message = message
        self.learnMoreLink = URL(string: learnMoreURL)
    }
}
