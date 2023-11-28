import SwiftUI
import SpriteKit
import AVFoundation

class GameFour: SKScene{
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let thanks = SKSpriteNode(imageNamed: "photos")
    let bnt = SKSpriteNode(imageNamed: "bntNext")
    var backgroundMusic: SKAudioNode!
    let congratulations = SKSpriteNode(imageNamed: "congratulationsEnd")
   
    override func sceneDidLoad() {
        if let musicURL = Bundle.main.path(forResource: "background_music_happy", ofType: "m4a") {
            backgroundMusic = SKAudioNode(url: URL(fileURLWithPath: musicURL) )
            addChild(backgroundMusic)
            backgroundMusic.run(.play())
        }
        thanks.size.width = UIScreen.main.bounds.width + 600
        thanks.size.height = UIScreen.main.bounds.height
        thanks.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        thanks.name = "thanks"
        addChild(thanks)
        
        bnt.name = "bnt"
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first_touch = touches.first else {
            return
        }
        let touch_location = first_touch.location(in: self)
        let node_touched = self.atPoint(touch_location)
        
        if let name_node = node_touched.name {
            
            if name_node == "bnt"{
                let change_scene = SKAction.run { [self] in
                    let gameView = GameView()
                    gameView.size = self.size
                    gameView.scaleMode = .aspectFill
                    self.view?.presentScene(gameView)
                }
              
                thanks.run(.sequence([  change_scene, ]))
                
            }else{
                
                let action1 = SKAction.run {
                    self.congratulations(node:self.congratulations)
                }
                let action2 = SKAction.run {
                    self.bnt(node:self.bnt)
                }
                let sequence = SKAction.sequence([
                    
                    action1,
                    action2
                ])
                run(sequence)
            }
            
        }
    }
    
    func bnt(node:SKNode){
        addChild(node)
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.wait(forDuration: 2),
                    SKAction.fadeOut(withDuration: 0.2),
                       SKAction.fadeIn(withDuration: 0.2),

                ])
              )
    }
    
    
    func congratulations(node: SKNode){
        addChild(node)
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.wait(forDuration: 5),

                ])
              )
    }
}


struct Previews_GameFour_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
