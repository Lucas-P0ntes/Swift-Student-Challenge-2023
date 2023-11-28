
import SwiftUI
import SpriteKit
import AVFoundation



class GameOne: SKScene, SKPhysicsContactDelegate{
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var walking = 1
    var fist = true
    
    //import Sprites
    let eu = SKSpriteNode(imageNamed: "eu-0001")
    let Dog = SKSpriteNode(imageNamed: "Dog-walking-1")
    let tag = SKSpriteNode(imageNamed: "tag")
    let tag2 = SKSpriteNode(imageNamed: "tag2")
    let alone = SKSpriteNode(imageNamed: "alone1")
    let bnt = SKSpriteNode(imageNamed: "bntNext")
    let hand = SKSpriteNode(imageNamed: "hand")
    let congratulations = SKSpriteNode(imageNamed: "congratulations1")
    var backgroundMusic: SKAudioNode!
    var labelNode = SKLabelNode(text: "")
    let ground = SKSpriteNode(color: .clear, size:CGSize(width: 10000, height: 285) )
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -10.0)
        
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
        
        
        Dog.size.width = screenWidth/4
        Dog.size.height = screenHeight/5
        Dog.position = CGPoint(x: 850 , y: screenHeight/4 )
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
        
        hand.size.width = 50
        hand.size.height =  50
        hand.name = "hand"
        addChild(hand)
        eu.position = CGPoint(x: 150, y: 300)
        eu.name = "eu"
        addChild(eu)
        
        let euSpriteSheet = [
            SKTexture (imageNamed: "eu-0001"),
            SKTexture (imageNamed: "eu-0002"),
            SKTexture (imageNamed: "eu-0007"),
            
        ]
        
        eu.run(
            .repeatForever(
                .animate(with: euSpriteSheet, timePerFrame: 0.3)))
        
        
        
        
        
        
        alone.size.width = screenWidth/4
        alone.size.height = screenHeight/5
        alone.position = CGPoint(x: -100 , y: screenHeight/1.5 )
        
        let aloneSpriteSheet = [
            SKTexture (imageNamed: "alone1"),
            SKTexture (imageNamed: "alone2"),
        ]
        alone.run(
            .repeatForever(
                .animate(with: aloneSpriteSheet, timePerFrame: 0.3)))
        
        
        labelNode.fontColor = .white
        labelNode.fontSize = 34
        labelNode.position = CGPoint(x: self.screenWidth/2, y: self.tag2.size.height / 1.2 )
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 24).fontName
        labelNode.numberOfLines = 0
        labelNode.lineBreakMode = .byWordWrapping
        labelNode.preferredMaxLayoutWidth = 1000
        
        let action1 = SKAction.run {
            self.nodeBoxText(node:self.tag2)
        }
        let action2 = SKAction.run {
            self.monster(node:self.alone)
        }
        let action3 = SKAction.run {
            self.textHelp(node: self.tag2)
        }
        let action4 = SKAction.run {
            self.dogBlinck(node: self.Dog)
        }
        let action5 = SKAction.run {
            self.dogClick(node: self.hand)
        }
        
        
        let sequence = SKAction.sequence([
            action1,
            SKAction.wait(forDuration: 12.0),
            action2,
            SKAction.wait(forDuration: 12.0),
            action3,
            SKAction.wait(forDuration: 7.0),
            action5,
            SKAction.wait(forDuration: 3.0),
            action4,
            SKAction.wait(forDuration: 3.0),
            action4,
            SKAction.wait(forDuration: 3.0),
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
            
            
            
            if (name_node == "Dog" ||  name_node == "hand" ) && self.fist == true {
                
                self.fist =  false
                
                let action4 = SKAction.run {
                    
                    self.getDog(node: self.eu)
                    
                }
                
                
                let action5 = SKAction.run {
                    self.congratulations(node:self.congratulations)
                }
                let action6 = SKAction.run {
                    self.bnt(node:self.bnt)
                }
                
                let sequence = SKAction.sequence([
                    action4,
                    
                    SKAction.wait(forDuration: 5.0),
                    action5,
                    action6
                    
                ]
                )
                run(sequence)
                
            }else if name_node == "bnt" {
                let change_scene = SKAction.run { [self] in
                    let level_two = GameTwo()
                    level_two.size = self.size
                    level_two.scaleMode = .aspectFill
                    self.view?.presentScene(level_two)
                }
                bnt.run(.sequence([ change_scene]))
            }
        }}
    
    func dogClick(node: SKNode){
        node.run(SKAction.sequence([
            SKAction.wait(forDuration: 2),
            SKAction.move(to: CGPoint(x: 870, y: screenHeight/6), duration: 2)
        ]))
        
    }
    func  dogBlinck(node:SKNode){
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
                    self.nodeText(node: self.labelNode ,text: "\n Dogs have a calming effect on people and can help \n  reduce anxiety by releasing oxytocin, a hormone that \n promotes feelings of calm and   well-being. Hug the \n puppy for the crisis to pass." ,time: 10 , color: .black)
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
        self.limparNode(Node: self.hand)
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
        
        let exit =  SKAction.run {
            self.limparNode(Node: self.alone)
            
        }
        
        let sequence = SKAction.sequence([
            walk,
            SKAction.wait(forDuration: 3),
            clear ,
            animation,
            exit
        ])
        
        
        
        eu.run(sequence)
        
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
                    self.nodeText(node: self.labelNode ,text: "Me: '... Should I go back? I will not move on!!!'",time: 4 , color: .blue)
                },
                SKAction.wait(forDuration: 5),
                SKAction.run {
                    self.nodeText(node: self.labelNode ,text: "Me: 'But I'm scared to be alone,\n  I think I'm having an anxiety attack' ",time: 5 , color: .blue)
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
                    self.nodeText(node: self.labelNode ,text: "Alone : hahahahahah",time: 4 , color: .red)
                },
                SKAction.wait(forDuration: 5),
                SKAction.run {
                    self.nodeText(node: self.labelNode,text: " Alone:  HAHAHAHAHA HAHAHAHA HAHA",time: 4 , color: .red)
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
        addChild(alone)
        node.run(
            SKAction.sequence([
                SKAction.moveTo(x: 200, duration: 1),
                
                SKAction.run {
                    self.nodeBoxText2(node:self.tag)
                },
                SKAction.wait(forDuration: 10),
                SKAction.moveTo(x: -200, duration: 1),
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

struct Previews_GameOne_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

