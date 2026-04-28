import SwiftUI

private enum ExportingPDFKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    /// A Boolean value that indicates whether the slide is currently being rendered for PDF export.
    public var isExportingPDF: Bool {
        get { self[ExportingPDFKey.self] }
        set { self[ExportingPDFKey.self] = newValue }
    }
}
