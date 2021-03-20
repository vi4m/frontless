import JavaScriptKit
import Logging

public let location = JSObject.global.location.object!
public let window = JSObject.global.window.object!
public let document = JSObject.global.document.object!
public let math = JSObject.global.Math.object!

let logger = Logger(label: "tokamak-bootstrap")
