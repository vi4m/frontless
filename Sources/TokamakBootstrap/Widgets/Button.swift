import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM

public typealias Style = [StyleCommand: String]


public struct MyModifiedContent<Content>  where Content: Dom{
    @Environment(\.self) public var environment
    public private(set) var content: Content
    
    public init(content: Content, style: Style) {
        self.content = content
        self.content.setStyle(style: style)
        
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
    case color = "color"
    case padding = "padding"
    case margin = "margin"
    case border = "border"
}


public class Dom {
    
    func getStyle() -> Style {
        self.style
    }
    
     func setStyle(style: Style) {
        self.style = style
    }
    
    var style: Style = [:]
    
    public init() {
    }
    
    public func getStyleText() -> String {
        self.getStyle().map { (key, value)  in
            "\(key.rawValue):\(value)"
        }.joined(separator: ";")
    }
}


class Button: Dom, View {
   
    let label: String
    
    @State var isPressed: Bool = false
    var action: () -> Void
    
    init(_ label: String,
         action: @escaping () -> Void)
    {
        self.action = action
        self.label = label
        
    }
    
    var body: some View {
        let listeners: [String: Listener] = [
            "pointerdown": { _ in self.isPressed = true },
            "pointerup": { [self] _ in
                self.isPressed = false
                action()
            },
        ]
        
        return AnyView(DynamicHTML(
            "a",
            ["class": "button", "style": self.getStyleText()],
            listeners: listeners, content: label
        )
        )
    }
}


extension Button {
    public func style(_ style: Style) -> some View { 
        return MyModifiedContent.init(content: self, style: style)
    }
    
    
}