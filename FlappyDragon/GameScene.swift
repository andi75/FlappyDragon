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
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.redColor()
        
        self.size = view.frame.size
        
        node = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(100, 100))
        node!.position = CGPointMake(self.frame.width / 2, self.frame.height / 2)
        
        rotate = SKAction.rotateByAngle( CGFloat(M_PI / 4.0), duration: 1.0)
        self.addChild(node!)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.backgroundColor = UIColor(hue: CGFloat(random()) / CGFloat(RAND_MAX), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        node?.runAction(rotate!)
        
        for touch in touches
        {
            let move = SKAction.moveTo(touch.locationInNode(self), duration: 1.0)
            node?.runAction(move)
        }
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
//        print(dt)
        
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
    }
}
