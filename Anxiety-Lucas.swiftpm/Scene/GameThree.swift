import SwiftUI
import SpriteKit
import AVFoundation

class GameThree: SKScene, SKPhysicsContactDelegate{
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fist = true
    
    
    //import Sprites
    let eu = SKSpriteNode(imageNamed: "eu-0001")
    let Dog = SKSpriteNode(imageNamed: "Dog-walking-1")
    let tag = SKSpriteNode(imageNamed: "tag")
    let tag2 = SKSpriteNode(imageNamed: "tag2")
    let bnt = SKSpriteNode(imageNamed: "bntNext")
    let hand = SKSpriteNode(imageNamed: "hand")
    let congratulations = SKSpriteNode(imageNamed: "congratulations3")
    var backgroundMusic: SKAudioNode!
    var labelNode = SKLabelNode(text: "")
    let ground = SKSpriteNode(color: .clear, size:CGSize(width: 10000, height: 285) )
    
    override func sceneDidLoad() {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -10.0)
        super.sceneDidLoad()
        
        // Efacts parallax
        back(imgfundo: "florest_game_sun", pos: -1 , velocidades: 100)
        back(imgfundo: "florest_game_sun2", pos: -2 , velocidades: 100)
        back(imgfundo: "florest_game_sun3", pos: -3 ,velocidades: 50 )
        back(imgfundo: "florest_game_sun4", pos: -4 , velocidades: 25)
        back(imgfundo: "florest_game_sun5", pos: -5 , velocidades: 10)
        
        if let musicURL = Bundle.main.path(forResource: "background_music_happy", ofType: "m4a") {
            backgroundMusic = SKAudioNode(url: URL(fileURLWithPath: musicURL) )
            if backgroundMusic.parent == nil {
                addChild(backgroundMusic)
                
            }
            backgroundMusic.run(.play())
        }
        
        bnt.name = "bnt"
        
        ground.name = "ground"
        ground.position = CGPoint(x: screenWidth , y: 10 )
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        if ground.parent == nil {
            addChild(ground)
        }
    
        
        Dog.size.width = screenWidth/4
        Dog.size.height = screenHeight/5
        Dog.position = CGPoint(x: 200 , y: screenHeight/4 )
        let DogSize = CGSize(width: Dog.size.width, height: Dog.size.height)
        Dog.name = "Dog"
        Dog.physicsBody = SKPhysicsBody(rectangleOf: DogSize)
        Dog.texture?.filteringMode = .nearest
        if Dog.parent == nil {
            addChild(Dog)
        }
        
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
        if eu.parent == nil {
            addChild(eu)
        }
        
        hand.size.width = 50
        hand.size.height =  50
        position = CGPoint(x: 850 , y: screenHeight )
        hand.name = "hand"
        if hand.parent == nil {
            addChild(hand)
        }
        
        let euSpriteSheet = [
            SKTexture (imageNamed: "euBem-0001"),
            SKTexture (imageNamed: "euBem-0002"),
            SKTexture (imageNamed: "euBem-0003"),
        ]
       
            eu.run(
                .repeatForever(
                    .animate(with: euSpriteSheet, timePerFrame: 0.3)))
            
        

        labelNode.fontColor = .white
        labelNode.fontSize = 34
        labelNode.position = CGPoint(x: self.screenWidth/2, y: self.screenHeight-200)
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 24).fontName
        labelNode.numberOfLines = 0
        labelNode.lineBreakMode = .byWordWrapping
        labelNode.preferredMaxLayoutWidth = 1200
        
        
        let action1 = SKAction.run {
            self.nodeBoxText(node:self.tag2)
        }
        let action2 = SKAction.wait(forDuration: 10);
        let action3 = SKAction.run {
            print("a")
            self.euClick(node: self.hand)
        }
        let action4 = SKAction.wait(forDuration: 3);
        let action5 = SKAction.run {
            self.euBlinck(node: self.eu)
        }
        
             let sequence = SKAction.sequence([
                 action1,
                 action2,
                 action3,
                 action4,
                 action5
               
             ]
             )
    
             run(sequence)
    }
    //---------------------------Funcs--------------------------

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("s")
        // identified the first touch //
        
        guard let first_touch = touches.first else {
            return
        }
        
        // identified the touch location //
        
        let touch_location = first_touch.location(in: self)
        
        let node_touched = self.atPoint(touch_location)
        
        if let name_node = node_touched.name {
            

            if ((name_node == "eu" || name_node == "hand") && self.fist == true){
                self.fist = false
               
                let action1 = SKAction.run {
                    self.textHelp(node: self.tag2)
                }
                
                let action2 = SKAction.run {
                    
                    self.move(node:self.Dog)
                    self.move(node:self.eu)
                }

              
                let action4 = SKAction.run {
                    self.congratulations(node:self.congratulations)
                }
                let action5 = SKAction.run {
                    self.bnt(node:self.bnt)
                }

             let sequence = SKAction.sequence([
               
                action1,
                SKAction.wait(forDuration: 5) ,
                action2,
                SKAction.wait(forDuration: 8) ,
                action4,
                action5
             ]
             )
                self.removeAllActions()
             run(sequence)
                
            }else if name_node == "bnt" {

                let change_scene = SKAction.run { [self] in
                    let gameFour = GameFour()
                    gameFour.size = self.size
                    gameFour.scaleMode = .aspectFill
                    self.view?.presentScene(gameFour)
                }
             bnt.run(.sequence([ change_scene]))
      
            }
            
        }}
    
    func euClick(node: SKNode){
        node.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: 100, y: screenHeight/6), duration: 2)

                                   ]))
    }
    
    
    func move(node:SKNode){
        node.run(SKAction.sequence([
            SKAction.moveTo(x: 1200, duration: 4),
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.limparNode(Node: node)
            },
        ]))
    }
    
    
    func textFim(node:SKNode){
        if node.parent == nil {
            addChild(node)
        }
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
    
    
    func  euBlinck(node:SKNode){
        node.run(
            SKAction.sequence([
        SKAction.fadeOut(withDuration: 0.2),
           SKAction.fadeIn(withDuration: 0.2),
            ])
          )
    }
    
    func bnt(node:SKNode){
        if node.parent == nil{
            addChild(node)
        }
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
        if node.parent == nil{
            addChild(node)
        }
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.wait(forDuration: 5),

                ])
              )
    }
    
        
    func textHelp(node: SKNode){
        self.limparNode(Node: self.hand)
        if node.parent == nil{
            addChild(node)
        }
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "Walks are a great  way to get outdoor exercise\n with your  dog and can help reduce  anxiety. \n Walking in nature, parks or trails can be particularly \n beneficial for relaxing and connecting with nature." ,time: 10 , color: .black)
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
    
    
    @objc func getDog(node:SKNode){
        let euDogSpriteSheet = [
            SKTexture (imageNamed: "eu-0003"),
            SKTexture (imageNamed: "eu-0004"),
            SKTexture (imageNamed: "eu-0005"),
            SKTexture (imageNamed: "eu-0006"),
         
        ]
        let walk =  SKAction.run { node.run(SKAction.moveTo(x: +730, duration: 2))
        }
        
        let clear =  SKAction.run{self.limparNode(Node: self.Dog)}

        let animation = SKAction.animate(with: euDogSpriteSheet, timePerFrame: 0.3)
    
           let pause = SKAction.pause()
           let sequence = SKAction.sequence([
            
            walk,
            SKAction.wait(forDuration: 3),
            clear ,
            animation,
            pause,
            ])
        
           eu.run(sequence)
    }
    
   
    
    func nodeBoxText(node:SKNode){
        if node.parent == nil{
            addChild(node)
        }
        node.position = CGPoint(x: 0, y: screenHeight/2)
           node.run(
               SKAction.sequence([
                    SKAction.moveTo(x: 550, duration: 1),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "Me: 'Wow, the day is so beautiful, and I feel so good.'",time: 4 , color: .blue)
                    },
                    SKAction.wait(forDuration: 5),
                    SKAction.run {
                        self.nodeText(node: self.labelNode ,text: "Me: 'I feel peaceful and calm. \n I think I will continue the walk with \n my dog for a while longer. ",time: 5 , color: .blue)
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
    
    func nodeText(node:SKNode, text: String , time: Float , color: UIColor ){
        labelNode.text = text
        labelNode.fontColor = color
        if node.parent == nil{
            addChild(node)
        }
        node.run(
            SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(time) ),
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
                if backgroundCopy.parent == nil{
                    addChild(backgroundCopy)
                }
                
        }
    }
}



