import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM

public typealias Style = [StyleCommand: String]
public typealias HTMLClasses = [String]

public struct MyModifiedContent<Content> where Content: Dom {
    @Environment(\.self) public var environment
    public private(set) var content: Content

    public init(content: Content, style: Style) {
        self.content = content
        self.content.setStyle(style: style)
    }

    public init(content: Content, klasses: HTMLClasses) {
        self.content = content
        self.content.setClass(klasses: klasses)
    }
}

extension MyModifiedContent: View, ParentView where Content: View {
    public var body: some View {
        return self.content.body
    }

    public var children: [AnyView] {
        [AnyView(content)]
    }
}

public enum StyleCommand: String {
    case backgroundColor = "background-color"
    case color
    case padding
    case margin
    case border
    case width
}

public class Dom {
    func getStyle() -> Style {
        style
    }

    func setStyle(style: Style) {
        self.style = style
    }

    func setClass(klasses: HTMLClasses) {
        self.klasses = klasses
    }

    func getKlasses() -> HTMLClasses {
        klasses
    }

    var style: Style = [:]
    var klasses: HTMLClasses = []

    public init() {}

    public func getStyleText() -> String {
        getStyle().map { key, value in
            "\(key.rawValue):\(value)"
        }.joined(separator: ";")
    }

    public func getClassesText() -> String {
        getKlasses().joined(separator: " ")
    }
}
