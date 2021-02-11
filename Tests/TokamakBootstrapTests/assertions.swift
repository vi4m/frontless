import Foundation
import XCTest

func AssertEnds(
           body: String, 
           with: String,
           file: StaticString = #file, line: UInt = #line
       ) {

    let bodyEndings = "<body style=\"margin: 0;display: flex;width: 100%;height: 100%;justify-content: center;align-items: center;overflow: hidden;\">"
//    
//    let bodyEndings = """
//    <body style="margin: 0;display: flex;
//    width: 100%;
//    height: 100%;
//    justify-content: center;
//    align-items: center;
//    overflow: hidden;">
//    """
    let body = body.replacingOccurrences(of: "\n",
                     with: "")
    if let range = body.range(of: bodyEndings) {
        let endMark = "</body></html>"
        let substring = body[range.upperBound...] 
        if substring == with + endMark  {
            XCTAssert(true, file: file, line: line)
        } else {
            XCTFail("\(substring) is not equal to expected: \(with + endMark)", file: file, line: line)
            print(substring.difference(from: with+endMark))
        }
    } else {
        XCTFail("Body endings not found")
    }
}

