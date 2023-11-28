import SwiftUI
import SpriteKit
import AVFoundation

class GameView: SKScene{
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let start = SKSpriteNode(imageNamed: "Start")
    
    override func sceneDidLoad() {
        start.size.width = UIScreen.main.bounds.width + 600
        start.size.height = UIScreen.main.bounds.height
        start.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        start.name = "start"
        if start.parent == nil {
            addChild(start)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let first_touch = touches.first else {
            return
        }
        let touch_location = first_touch.location(in: self)
        
        let node_touched = self.atPoint(touch_location)
        
        if let name_node = node_touched.name {
            
            if name_node == "start"{

                let change_scene = SKAction.run { [self] in
                    let gameOne = GameOne()
                    gameOne.size = self.size
                    gameOne.scaleMode = .aspectFill
                    self.view?.presentScene(gameOne)
                }
                start.run(.sequence([  change_scene, ]))
            }
        }
    }
}


struct Previews_GameView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
