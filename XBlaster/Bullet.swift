//
//  Bullet.swift
//  XBlaster
//
//  Created by Charles Hsu on 12/11/14.
//  Copyright (c) 2014 Loxoll. All rights reserved.
//

import SpriteKit

class Bullet: Entity {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(entityPosition: CGPoint) {
        let entityTexture = Bullet.generateTexture()!
        super.init(position: entityPosition, texture: entityTexture)
        name = "bullet"
    }
    
    override class func generateTexture() -> SKTexture? {
        
        struct SharedTexture {
            
            static var texture = SKTexture()
            static var onceToken: dispatch_once_t = 0
        
        }
        
        dispatch_once(&SharedTexture.onceToken, {
            let cannon = SKLabelNode(fontNamed: "Arial")
            cannon.name = "bullet"
            cannon.fontSize = 40
            cannon.fontColor = SKColor.whiteColor()
            cannon.text = "•"
            
            let textureView = SKView()
            SharedTexture.texture = textureView.textureFromNode(cannon)
            SharedTexture.texture.filteringMode = .Nearest
        })
        
        return SharedTexture.texture
        
    }
    
    
}
