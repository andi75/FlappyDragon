//
//  GameScene.swift
//  FlappyDragon
//
//  Created by Andreas Umbach on 23.09.2015.
//  Copyright © 2015 Andreas Umbach. All rights reserved.
//

import SpriteKit

class GameScene : SKScene
{
    var lasttime : NSTimeInterval = 0
    
    var rotate : SKAction? = nil
    var node : SKSpriteNode? = nil
    var ground : SKSpriteNode? = nil
    var triangle : SKShapeNode? = nil
    
    let gravity : CGFloat = -5.0
    let dragonSpeed : CGFloat = 200.0
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.redColor()
        
        self.size = view.frame.size
        
        self.physicsWorld.gravity = CGVectorMake(0, gravity)
        
        node = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(100, 100))
        node!.position = CGPointMake(self.frame.width / 2, self.frame.height / 2)
        
        node!.physicsBody = SKPhysicsBody(rectangleOfSize: node!.size)
        node!.physicsBody?.velocity = CGVectorMake(0, 0)
        self.addChild(node!)
        
        ground = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.size.width, 100))
        ground?.position = CGPointMake(ground!.size.width / 2, ground!.size.height / 2)
        ground?.physicsBody = SKPhysicsBody(rectangleOfSize: ground!.size)
        ground?.physicsBody?.dynamic = false
        self.addChild(ground!)
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, -50.0, -1.0 / 3.0 * (sqrt(3.0) / 2) * 100)
        CGPathAddLineToPoint(path, nil, +50.0, -1.0 / 3.0 * (sqrt(3.0) / 2) * 100)
        CGPathAddLineToPoint(path, nil, 0, 2.0 / 3.0 * (sqrt(3.0) / 2) * 100)
        CGPathCloseSubpath(path)
        
        triangle = SKShapeNode(path: path)
        triangle?.strokeColor = UIColor.blueColor()
        triangle?.lineWidth = 3.0
        triangle?.fillColor = UIColor.blackColor()
        triangle?.position = CGPointMake(self.frame.width / 2, self.frame.height - 100)
        triangle?.physicsBody = SKPhysicsBody(polygonFromPath: path)
//        triangle?.physicsBody?.affectedByGravity = true
//        triangle?.physicsBody?.dynamic = true
        
        self.addChild(triangle!)
    
        rotate = SKAction.rotateByAngle( CGFloat(M_PI / 4.0), duration: 1.0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.backgroundColor = UIColor(hue: CGFloat(random()) / CGFloat(RAND_MAX), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        node?.runAction(rotate!)
        
        node?.physicsBody?.velocity = CGVectorMake(0, 0)
        node?.physicsBody?.applyImpulse(CGVectorMake(0, dragonSpeed))
        
//        for touch in touches
//        {
//            let move = SKAction.moveTo(touch.locationInNode(self), duration: 1.0)
//            node?.runAction(move)
//        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        if(lasttime == 0)
        {
            lasttime = currentTime
        }
        
        let dt = currentTime - lasttime
        if(dt > 0.01)
        {
            doUpdate(CGFloat(dt))
            lasttime = currentTime
        }
    }
    
    func doUpdate(dt: CGFloat)
    {
        // print(dt)
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        self.backgroundColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        hue = hue + 1.0 / 3.0 * dt
        if(hue >= 1.0)
        {
            hue = hue - 1.0
        }
        self.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        // print(node?.physicsBody?.velocity)
    }
}
