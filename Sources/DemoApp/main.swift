import CombineShim
import Foundation
import Frontless
import JavaScriptKit
import Logging
import TokamakDOM

LoggingSystem.bootstrap { _ in StreamLogHandler.standardOutput(label: "demo-app") }

var logger = Logger(label: "demo-app")
logger.logLevel = .debug

struct DemoApp: App {
  var body: some Scene {
    WindowGroup(" ⛢ Demo") {
      ContentView().environmentObject(ErrorsViewModel())
    }
  }
}

struct ContentView: View {
  @StateObject var hashState = HashState()
  @State var button: JSObject?

  @EnvironmentObject var errorViewModel: ErrorsViewModel
  @State var menuItems: [MenuItem] = []

  @State var currentPage: AnyView?
  @State var cancellable: AnyCancellable? = nil

  var body: some View {
    Div(
      id: "root",
      style:
        "overflow-x: hidden; overflow-y: scroll; display: block; justify-content: left; width: 100%; height: 100%"
    ) {
      // Upper menu
      Row {
        NavBar(title: "uJira") {
          ForEach(self.getMenu(), id: \.href) { (item: MainMenu) in
            item
          }
        }

        if errorViewModel.show {
          Error(error: $errorViewModel.message, show: $errorViewModel.show)
        }
      }
      Row {
        //                if !menuItems.isEmpty {
        //                    Col(width: 2) {
        //                        Menu(items: $menuItems)
        //                    }
        //                }
        // Content page
        Col(width: 11) {
          currentPage
        }
      }
    }._onMount {
      self.cancellable = hashState.$currentPage.sink { [self] value in
        currentPage = self.dispatchMenu(page: value)
      }
    }
  }
}

_ = document.head.object!.insertAdjacentHTML!(
  "beforeend",
  #"""
  <style type="text/css">
      :root {
          --header-fore-color: white;
          --header-back-color: #0399a7;
          --nav-background-color: #0399a7;
          --header-hover-back-color: #02568a; 
      }

      header a.logo {
          text-transform: none;
      }

      .s {

          min-width: 800px;
          transition: all 0.5s ease-in;
      }

      navbar {
      box-shadow: 0 0.5rem 1rem rgb(0 0 0 / 5%), inset 0 -1px 0 rgb(0 0 0 / 15%);
      }

      a.logo {
      color: white;
          padding-top: 6px;
      }

      .s > table {
          width: 100%
      }

      .overlay {
          z-index: 100000000;
          position: absolute;
          left: 0;
          top: 0;
          height: 100vh;
          width: 100vw;
          background-color: rgba(0,0,0,0.4);
          display: flex;
          justify-content: center;
          align-items: center;
      }

      body > div {
          overflow: scroll; 
          display: block;
      }

      header a.button:focus {
          background: var(--header-back-color);
      }

  </style>
  """#)

DemoApp.main()
