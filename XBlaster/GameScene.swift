//
//  GameScene.swift
//  XBlaster
//
//  Created by Charles Hsu on 12/9/14.
//  Copyright (c) 2014 Loxoll. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let playerLayerNode = SKNode()
    let hudLayerNode = SKNode()
    
    let playableRect: CGRect
    let hudHeight: CGFloat = 90
    
    let scoreLabel = SKLabelNode(fontNamed: "Edit Undo Line BRK")
    let healthBarString: NSString = "====================" // !!! NSString must be declared
    let playerHealthLabel = SKLabelNode(fontNamed: "Arial")
    
    var scoreFlashAction: SKAction!
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0 // iPhone 5.0
        let maxAspectRatioWidth: CGFloat = size.height / maxAspectRatio
        let playableMargin = (size.width - maxAspectRatioWidth) / 2.0
        playableRect = CGRect(x: playableMargin, y: 0,
                              width: size.width - playableMargin / 2,
                              height: size.height - hudHeight)

        super.init(size: size)
        
        setupSceneLayers()
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSceneLayers() {
        playerLayerNode.zPosition = 50
        hudLayerNode.zPosition = 100
        
        addChild(playerLayerNode)
        addChild(hudLayerNode)
    }
 
    func setupUI() {
        
        let backgroundSize = CGSize(width: size.width, height: hudHeight)
        let backgroundColor = SKColor.blackColor()
        let hudBarBackground = SKSpriteNode(color: backgroundColor, size: backgroundSize)
        
        hudBarBackground.position = CGPoint(x: 0, y: size.height - hudHeight)
        hudBarBackground.anchorPoint = CGPointZero
        
        hudLayerNode.addChild(hudBarBackground)
        
        scoreLabel.fontSize = 50
        scoreLabel.text = "Score: 0"
        scoreLabel.name = "scoreLabel"
        
        scoreLabel.verticalAlignmentMode = .Center
        scoreLabel.position = CGPoint(x: size.width / 2,
                                      y: size.height - scoreLabel.frame.size.height + 3)
        
        hudLayerNode.addChild(scoreLabel)
        
        scoreFlashAction = SKAction.sequence([
            SKAction.scaleTo(1.5, duration: 0.1),
            SKAction.scaleTo(1.0, duration: 0.1)])
        
        scoreLabel.runAction(SKAction.repeatAction(scoreFlashAction, count: 20))
        
        let playerHealthBackgroundLabel = SKLabelNode(fontNamed: "Arial")
        
        playerHealthBackgroundLabel.name = "playerHealthBackground"
        playerHealthBackgroundLabel.fontColor = SKColor.darkGrayColor()
        playerHealthBackgroundLabel.fontSize = 50
        playerHealthBackgroundLabel.text = healthBarString
        
        playerHealthBackgroundLabel.horizontalAlignmentMode = .Left
        playerHealthBackgroundLabel.verticalAlignmentMode = .Top
        playerHealthBackgroundLabel.position = CGPoint(
            x: CGRectGetMinX(playableRect),
            y: size.height - CGFloat(hudHeight)
                + playerHealthBackgroundLabel.frame.size.height)
        
        hudLayerNode.addChild(playerHealthBackgroundLabel)
        
        playerHealthLabel.name = "playerHealthLabel"
        playerHealthLabel.fontColor = SKColor.greenColor()
        playerHealthLabel.fontSize = 50
        playerHealthLabel.text = healthBarString.substringToIndex(20*75/100)
                               //healthBarString.substringToIndex(index: String.Index)
        playerHealthLabel.horizontalAlignmentMode = .Left
        playerHealthLabel.verticalAlignmentMode = .Top
        playerHealthLabel.position = CGPoint(
            x: CGRectGetMinX(playableRect),
            y: size.height - CGFloat(hudHeight) + playerHealthLabel.frame.size.height)
        
        hudLayerNode.addChild(playerHealthLabel)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
