//
//  PresentationView.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/24.
//

#if canImport(AppKit)
import AppKit
#endif
import SwiftUI

public struct PresentationView<Content>: View where Content: View {

    private let slideSize: CGSize
    private let content: () -> Content

#if canImport(AppKit)
    private let windowEventHandler: PresentationWindowEventHandler
#endif

    public init(slideSize: CGSize, content: @escaping () -> Content) {
        self.slideSize = slideSize
        self.content = content
#if canImport(AppKit)
        self.windowEventHandler = PresentationWindowEventHandler(slideSize: slideSize)
#endif
    }

    public var body: some View {
        ZStack(alignment: .center) {
          #if !os(visionOS)
            Color.black
          #endif
            SlideScreen(slideSize: slideSize) {
                content()
            }
#if canImport(AppKit)
            .aspectRatio(slideSize, contentMode: .fit)
            .clipped()
#else
            .clipped()
            .aspectRatio(slideSize, contentMode: .fit)
#endif

        }
        .ignoresSafeArea()
#if canImport(AppKit)
        .configureWindow { window in
            window?.delegate = windowEventHandler
            window?.standardWindowButton(.zoomButton)?.isHidden = true
            window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window?.standardWindowButton(.closeButton)?.isHidden = true
        }
#endif
    }
}

#if canImport(AppKit)
public class PresentationWindowEventHandler: NSObject, NSWindowDelegate {
    public let slideSize: CGSize

    init(slideSize: CGSize) {
        self.slideSize = slideSize
    }

    public func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        NSSize(width: slideSize.ratio * frameSize.height, height: frameSize.height)
    }
}
#endif
