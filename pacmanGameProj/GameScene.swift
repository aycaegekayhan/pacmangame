//
//  GameScene.swift
//  pacmanGameProj
//
//  Created by Ayça ege Kayhan on 10/15/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var actionChew:SKAction = SKAction(named: "Chew")! //(!) is to check that if action exist
    var thePacMan:SKSpriteNode = SKSpriteNode()
    var theStrawberry:SKSpriteNode = SKSpriteNode()
    var theApple:SKSpriteNode = SKSpriteNode()
    
    var emptyLocArray = [CGPoint]() //array stores where character can move in maze
    
    override func didMove(to view: SKView) {
        
        theStrawberry = (self.childNode(withName: "strawberry") as! SKSpriteNode)
        thePacMan = (self.childNode(withName: "pacman") as! SKSpriteNode)
        theApple = (self.childNode(withName: "apple") as! SKSpriteNode)
        
        
        
        for node in self.children { //iterate through all the children in the scene
            
            if (node is SKTileMapNode) {
                
                if let theOut:SKTileMapNode = node as? SKTileMapNode { //confirms that node is sktilemap node
                    
                    structSceneMap(map:theOut)
                    theOut.physicsBody?.collisionBitMask = 1
                    theOut.physicsBody?.categoryBitMask = 2
                    theOut.physicsBody?.contactTestBitMask = 0
                    theOut.physicsBody?.restitution = 1
                    theOut.physicsBody?.allowsRotation = true
                    theOut.physicsBody?.friction = 1
                }
                
            }
            
        }
        
        self.physicsWorld.contactDelegate = self
        
        if (self.childNode(withName: "pacman") != nil) {
            thePacMan = self.childNode(withName: "pacman") as! SKSpriteNode
            thePacMan.run(actionChew, withKey: "Chew")
        }
        
    }
    
    func structSceneMap(map:SKTileMapNode) {
        
        let tileSize = map.tileSize
        
        let divW = CGFloat (map.numberOfColumns) / 2.0 * tileSize.width // half of the width
        let divH = CGFloat (map.numberOfRows) / 2.0 * tileSize.height // half of the height
        
        for column in 0..<map.numberOfColumns { //iterate through every column
            
            for row in 0..<map.numberOfRows { //iterate through every row
            //together they iterate every spot on the grid
                
                if let paintTile = map.tileDefinition(atColumn: column, row: row) {
                    // tile with painting exist
                } else {
                    //tile is empty character can move within these tiles
                    
                    let locY = CGFloat(row) * tileSize.height - divW + (tileSize.width / 2)
                    let locX = CGFloat(column) * tileSize.width - divH + (tileSize.height / 2)
                    
                    let pointNew = CGPoint(x: locX, y: locY)
                    let convPointNew:CGPoint = self.convert(pointNew, from: map) //converts empty spots in map
                    
                    emptyLocArray.append(convPointNew)
                    
                    
                }
                
            }
            
        }
        
    }
    
    func didBegin(_ collide:SKPhysicsContact){
        print("GOT INTO FUNCTION")
        
        if (collide.bodyA.node?.name == "strawberry" || collide.bodyA.node?.name == "apple" ){
            collide.bodyA.node?.removeFromParent()
        } else if(collide.bodyB.node?.name == "strawberry" || collide.bodyB.node?.name == "apple" ){
            collide.bodyB.node?.removeFromParent()
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                thePacMan.position.x = location.x
                thePacMan.position.y = location.y
            }
        }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}
