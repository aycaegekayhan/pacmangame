//
//  GameScene.swift
//  pacmanGameProj
//
//  Created by Ayça ege Kayhan on 10/15/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var emptyLocArray = [CGPoint]() //array stores where character can move in maze
    
    override func didMove(to view: SKView) {
        
        for node in self.children { //iterate through all the children in the scene
            
            if (node is SKTileMapNode) {
                
                if let theOut:SKTileMapNode = node as? SKTileMapNode { //confirms that node is sktilemap node
                    
                    structSceneMap(map:theOut)
                    
                }
                
            }
            
        }
    }
    
    func structSceneMap(map:SKTileMapNode) {
        
        let tileSize = map.tileSize
        
        let divW = CGFloat (map.numberOfColumns) / 2.0 * tileSize.width
        
        print(divW)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}
