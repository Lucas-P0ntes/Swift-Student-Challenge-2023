import SwiftUI
import SpriteKit
import AVFoundation

class GameTwo: SKScene, SKPhysicsContactDelegate{
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fist = true
    
    
    //import Sprites
    let eu = SKSpriteNode(imageNamed: "eu-0001")
    let Dog = SKSpriteNode(imageNamed: "Dog-walking-1")
    let tag = SKSpriteNode(imageNamed: "tag")
    let tag2 = SKSpriteNode(imageNamed: "tag2")
    let uncertainty = SKSpriteNode(imageNamed: "uncertainty.1")
    let stick = SKSpriteNode(imageNamed: "stick")
    let bnt = SKSpriteNode(imageNamed: "bntNext")
    let hand = SKSpriteNode(imageNamed: "hand")
    let congratulations = SKSpriteNode(imageNamed: "congratulations2")
    var backgroundMusic: SKAudioNode!
    var labelNode = SKLabelNode(text: "")
    let ground = SKSpriteNode(color: .clear, size:CGSize(width: 10000, height: 285) )
    
    override func sceneDidLoad() {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -10.0)
        super.sceneDidLoad()
        
        // Efacts parallax
        back(imgfundo: "forest_game_1", pos: -1 , velocidades: 100)
        back(imgfundo: "forest_game_99", pos: -2 , velocidades: 100000)
        back(imgfundo: "forest_game_2", pos: -3 ,velocidades: 50 )
        back(imgfundo: "forest_game_3", pos: -4 , velocidades: 25)
        back(imgfundo: "forest_game_4", pos: -5 , velocidades: 7)
        
        if let musicURL = Bundle.main.path(forResource: "background_music", ofType: "m4a") {
            backgroundMusic = SKAudioNode(url: URL(fileURLWithPath: musicURL) )
            addChild(backgroundMusic)
            backgroundMusic.run(.play())
        }
        
        
        bnt.name = "bnt"
        
        ground.name = "ground"
        ground.position = CGPoint(x: screenWidth , y: 10 )
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        addChild(ground)
        
        stick.position = CGPoint(x: 150, y: 270)
        
        
        Dog.size.width = screenWidth/4
        Dog.size.height = screenHeight/5
        Dog.position = CGPoint(x: 200 , y: screenHeight/4 )
        let DogSize = CGSize(width: Dog.size.width, height: Dog.size.height)
        Dog.name = "Dog"
        Dog.physicsBody = SKPhysicsBody(rectangleOf: DogSize)
        Dog.texture?.filteringMode = .nearest
        addChild(Dog)
        
        let DogSpriteSheet = [
            SKTexture (imageNamed: "Dog-walking-1"),
            SKTexture (imageNamed: "Dog-walking-2"),
            SKTexture (imageNamed: "Dog-walking-3"),
            SKTexture (imageNamed: "Dog-walking-4"),
            SKTexture (imageNamed: "Dog-walking-5"),
        ]
        
        Dog.run(.repeatForever(.animate(with: DogSpriteSheet, timePerFrame: 0.1)))
        
      
        
        eu.position = CGPoint(x: 150, y: 300)
        eu.name = "eu"
        addChild(eu)
        
        hand.size.width = 50
        hand.size.height =  50
        position = CGPoint(x: 850 , y: screenHeight )
        hand.name = "hand"
        addChild(hand)
        
        let euSpriteSheet = [
            SKTexture (imageNamed: "eu-0001"),
            SKTexture (imageNamed: "eu-0002"),
            SKTexture (imageNamed: "eu-0007"),
            
        ]
       
            eu.run(
                .repeatForever(
                    .animate(with: euSpriteSheet, timePerFrame: 0.3)))
            
      
        
        
        
        
        uncertainty.size.width = screenWidth/4
        uncertainty.size.height = screenHeight/5
        uncertainty.position = CGPoint(x: 1200 , y: screenHeight/1.5 )
        
        let aloneSpriteSheet = [
            SKTexture (imageNamed: "uncertainty1"),
            SKTexture (imageNamed: "uncertainty2"),
            SKTexture (imageNamed: "uncertainty3"),
        ]
        uncertainty.run(
            .repeatForever(
                .animate(with: aloneSpriteSheet, timePerFrame: 0.3)))
        
        
        labelNode.fontColor = .white
        labelNode.fontSize = 34
        labelNode.position = CGPoint(x: self.screenWidth/2, y: self.screenHeight-200)
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 24).fontName
        labelNode.numberOfLines = 0
        labelNode.lineBreakMode = .byWordWrapping
        labelNode.preferredMaxLayoutWidth = 1000
        
            let action1 = SKAction.run {
                self.nodeBoxText(node:self.tag2)
            }
            let action2 = SKAction.run {
                self.monster(node:self.uncertainty)
            }

            let action3 = SKAction.run {
                self.textHelp(node: self.tag2)
            }
          
            let action4 = SKAction.run {
                self.euBlinck(node:self.eu)
            }
            let action5 = SKAction.run {
                self.euClick(node: self.hand)
            }
    
    
             let sequence = SKAction.sequence([
                 action1,
                 SKAction.wait(forDuration: 12.0),
                 action2,
                 SKAction.wait(forDuration: 17.0),
                 action3,
                 SKAction.wait(forDuration: 12.0),
                 action5,
                 SKAction.wait(forDuration: 3.0),
                 action4,
                 SKAction.wait(forDuration: 5.0),
                 action4,
            
             ]
             )
    
             run(sequence)

    }
    
    //---------------------------Funcs--------------------------

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // identified the first touch //
        
        guard let first_touch = touches.first else {
            return
        }
        // identified the touch location //
        
        let touch_location = first_touch.location(in: self)
        
        let node_touched = self.atPoint(touch_location)
        
        if let name_node = node_touched.name {
            
           
           
            if (name_node == "eu" ||  name_node == "hand") && self.fist == true {
                self.fist = false
                let action1 = SKAction.run {
                    self.throwStick(node:self.stick)
                }
                let action2 = SKAction.run {
                    self.moveDog(node:self.Dog)
                }

                let action3 = SKAction.run {
                    self.textFim(node: self.tag2)
                }
                let action = SKAction.run {
                    self.limparNode(Node: self.stick)
                }
                let action4 = SKAction.run {
                    self.congratulations(node:self.congratulations)
                }
                let action5 = SKAction.run {
                    self.bnt(node:self.bnt)
                }
        
                
             let sequence = SKAction.sequence([
                action1,
                action2,
                SKAction.wait(forDuration: 10) ,
                action3,
                action,
                SKAction.wait(forDuration: 8) ,
                action4,
                action5
             ]
             )
    
             run(sequence)

            }else if name_node == "bnt" {
                
                
                let change_scene = SKAction.run { [self] in
                    let  gameThree = GameThree()
                    gameThree.size = self.size
                    gameThree.scaleMode = .aspectFill
                    self.view?.presentScene(gameThree)
                }
                
             bnt.run(.sequence([ change_scene]))
                
                
                
                
            }
            
            
        }}
    
    
    
    
    func throwStick(node: SKNode){
        self.limparNode(Node: self.hand)
        addChild(node)
        node.run(SKAction.sequence([
            SKAction.moveTo(x: 600, duration: 2),
            SKAction.wait(forDuration: 1),
            SKAction.wait(forDuration: 1),
            SKAction.wait(forDuration: 1),

            SKAction.moveTo(x: 150, duration: 3),
            SKAction.wait(forDuration: 10)
            ]))
        //self.limparNode(Node: node)

        }
    
    func moveDog(node:SKNode){
        node.run(SKAction.sequence([
            SKAction.moveTo(x: 600, duration: 4),
            SKAction.wait(forDuration: 1),
            SKAction.moveTo(x: 150, duration: 3),
        ]))
        
    
    }
    
    func textFim(node:SKNode){
        
        addChild(node)
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "Me: 'This is fun, our time is passing fast.'" ,time: 5 , color: .black)
                    },
                    SKAction.wait(forDuration: 5),
                    SKAction.moveTo(x: 2000, duration: 2),
                    SKAction.wait(forDuration: 1),
                    SKAction.run{
                        self.limparNode(Node: node)
                    },
                ])
              )
    }
    
    func euClick(node: SKNode){
        node.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: 100, y: screenHeight/6), duration: 2)

                                   ]))

    }
    
    
    func  euBlinck(node:SKNode){
        node.run(
            SKAction.sequence([
        SKAction.fadeOut(withDuration: 0.2),
           SKAction.fadeIn(withDuration: 0.2),
            ])
          )
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
    
        
    func textHelp(node: SKNode){
        addChild(node)
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "\n Interacting with a dog can distract a person from \n anxiety and help them focus on something positive.\n Taking the uncertainties out of your mind." ,time: 10 , color: .black)
                    },
                    SKAction.wait(forDuration: 10),
                    SKAction.moveTo(x: 2000, duration: 2),
                    SKAction.wait(forDuration: 1),
                    SKAction.run{
                        self.limparNode(Node: node)
                    },
                ])
              )
       }
    
    
    func nodeText(node:SKNode, text: String , time: Float , color: UIColor ){
        labelNode.text = text
        labelNode.fontColor = color
        addChild(node)
        node.run(
            SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(time) ),
                SKAction.run {
                    self.limparNode(Node: node)
                }
            ])
        )
    }
    
    func nodeBoxText(node:SKNode){
        addChild(node)
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "Me: 'Wouldn't it be better for me to go back'",time: 4 , color: .blue)
                    },
                    SKAction.wait(forDuration: 5),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "Me: 'but moving forward is important' ",time: 5 , color: .blue)
                    },
                    
                    SKAction.wait(forDuration: 5),
                    SKAction.moveTo(x: 2000, duration: 2),
                    SKAction.wait(forDuration: 1),
                    SKAction.run{
                        self.limparNode(Node: node)
                    },
                ])
              )
       }
    func nodeBoxText2(node:SKNode){
        addChild(node)
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "Uncertainty head 1:'hahaha will it work???'  ",time: 4 , color: .red)
                    },
                    SKAction.wait(forDuration: 5),
                    SKAction.run {
                        self.nodeText(node: self.labelNode,text: "Uncertainty head 2:'What will happen if you don't \n make it?",time: 4 , color: .red)
                    },
                    SKAction.wait(forDuration: 5),
                    SKAction.run {
                        self.nodeText(node: self.labelNode,text: "Uncertainty head 3:'hahaha what if there's \n nothing up front?",time: 4 , color: .red)
                    },
                    SKAction.wait(forDuration: 4),
                    SKAction.moveTo(x: 2000, duration: 2),
                    SKAction.wait(forDuration: 1),
                    SKAction.run{
                        self.limparNode(Node: node)
                    },
                ])
              )
       }
   
    func monster(node:SKNode){
        addChild(uncertainty)
        node.run(
            SKAction.sequence([
                SKAction.moveTo(x: 900, duration: 1),
                
                SKAction.run {
                    self.nodeBoxText2(node:self.tag)
                },
                SKAction.wait(forDuration: 15),
                SKAction.moveTo(x: 1200, duration: 1),
                SKAction.run {
                    self.limparNode(Node: node)
                }
            ])
        )
    }
   

    func limparNode(Node: SKNode){
        //Remove todos os nós filhos da cena atual
        Node.removeFromParent()
    }
    
    func back (imgfundo: String, pos : Float ,velocidades : Double ){
          let velocidade = velocidades
        
 
            let backgroundTexture = SKTexture(imageNamed: "\(imgfundo)")
            let backgroundSize = CGSize(width: screenWidth, height: screenHeight)
            let background = SKSpriteNode(texture: backgroundTexture, size: backgroundSize)
           
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint.zero
            background.zPosition = -1
            background.texture?.filteringMode = .nearest
        background.name = "\(background)"
            let offsetX = backgroundSize.width
            let moveLeft = SKAction.moveBy(x: -offsetX, y: 0, duration: velocidade)
            let moveReset = SKAction.moveBy(x: offsetX, y: 0, duration: 0.0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            
            for i in 0..<2 {
                let backgroundCopy = background.copy() as! SKSpriteNode
                backgroundCopy.position = CGPoint(x: CGFloat(i) * offsetX, y: 0)
                backgroundCopy.run(moveForever)
                addChild(backgroundCopy)
        }
    }
}
struct Previews_GameTwo_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
