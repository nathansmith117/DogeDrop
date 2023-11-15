//
//  EndGameScene.swift
//  DogeDrop
//
//  Created by Smith, Nathanael on 11/15/23.
//

import SpriteKit

class EndGameScene : SKScene
{
    var score : Int = 0
    
    override func didMove(to view : SKView) -> Void
    {
        backgroundColor = UIColor.orange
        
        let scoreNode = SKLabelNode(fontNamed: "Copperplate-Bold")
        scoreNode.fontSize = 20
        scoreNode.fontColor = .black
        scoreNode.zPosition = 2
        scoreNode.position.x = frame.midX
        scoreNode.position.y = frame.midY + 30
        scoreNode.text = "Score: \(score)"
        
        let endNode = SKLabelNode(fontNamed: "Copperplate-Bold")
        endNode.fontSize = 20
        endNode.fontColor = .black
        endNode.zPosition = 2
        endNode.position.x = frame.midX
        endNode.position.y = frame.midY + 10
        endNode.text = "GAME OVER!!"
        
        let restartNode = SKLabelNode(fontNamed: "Copperplate-Bold")
        restartNode.fontSize = 20
        restartNode.fontColor = .black
        restartNode.zPosition = 2
        restartNode.position.x = frame.midX
        restartNode.position.y = frame.midY - 10
        restartNode.text = "Pinch to restart!!!"
        
        addChild(scoreNode)
        addChild(endNode)
        addChild(restartNode)
    }
}
