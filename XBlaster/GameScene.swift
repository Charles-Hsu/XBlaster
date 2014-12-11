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
    let bulletLayerNode = SKNode()
    
    let playableRect: CGRect
    let hudHeight: CGFloat = 90
    
    let scoreLabel = SKLabelNode(fontNamed: "Edit Undo Line BRK")
    let healthBarString: NSString = "====================" // !!! NSString must be declared
    let playerHealthLabel = SKLabelNode(fontNamed: "Arial")
    
    var scoreFlashAction: SKAction!
    var playerShip: PlayerShip!
    
    // track the distance the player's finger moves
    var deltaPoint = CGPointZero
    
    // Challenge 1: The plasma cannon
    var bulletInterval: NSTimeInterval = 0
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0 // iPhone 5"
        let maxAspectRatioWidth: CGFloat = size.height / maxAspectRatio
        let playableMargin = (size.width - maxAspectRatioWidth) / 2.0
        playableRect = CGRect(x: playableMargin, y: 0,
                              //width: size.width - playableMargin / 2,
                            width: maxAspectRatioWidth,
                            height: size.height - hudHeight)

        super.init(size: size)
        
        setupSceneLayers()
        
        setupUI()
        
        setupEntities()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let currentPoint = touch.locationInNode(self)
        let previousTouchLocation = touch.previousLocationInNode(self)
        deltaPoint = currentPoint - previousTouchLocation
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        deltaPoint = CGPointZero
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        deltaPoint = CGPointZero
    }

    func setupSceneLayers() {
        playerLayerNode.zPosition = 50
        hudLayerNode.zPosition = 100
        bulletLayerNode.zPosition = 25
        
        addChild(playerLayerNode)
        addChild(hudLayerNode)
        addChild(bulletLayerNode)
    }
    
    func setupEntities() {
        playerShip = PlayerShip(
            entityPosition: CGPoint(x: size.width/2, y: 100))
        playerLayerNode.addChild(playerShip)
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
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // calculate the new position of the ship
        var newPoint:CGPoint = playerShip.position + deltaPoint
        
        // 2
        newPoint.x.clamp(CGRectGetMinX(playableRect), CGRectGetMaxX(playableRect))
        newPoint.y.clamp(CGRectGetMinY(playableRect), CGRectGetMaxY(playableRect))
        
        // 3
        playerShip.position = newPoint
        deltaPoint = CGPointZero
        
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }
        else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
        bulletInterval += dt
        
        if bulletInterval > 0.15 {
            bulletInterval = 0
            
            // 1: Create Bullet
            let bullet = Bullet(entityPosition: playerShip.position)
            
            // 2: Add to scene
            bulletLayerNode.addChild(bullet)
            
            // 3: Sequence: Move up screen, remove from parent
            bullet.runAction(SKAction.sequence([
                SKAction.moveByX(0, y: size.height, duration: 1),
                SKAction.removeFromParent()
            ]))
        }
        
    }
}














