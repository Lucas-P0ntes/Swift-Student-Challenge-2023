import SwiftUI
import SpriteKit
import AVKit

struct ContentView: View {

    var scene: SKScene {
        let scene = GameView()
            scene.size = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
            scene.scaleMode = .aspectFill
        
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
           .ignoresSafeArea ()
        
    }
        
}
