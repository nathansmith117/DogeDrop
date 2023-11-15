//
//  GameScene.swift
//  DogeDrop
//
//  Created by Smith, Nathanael on 11/13/23.
//

import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate
{
    private var colorMask : Int = 0b0000
    private let scoreNode : SKLabelNode = SKLabelNode(fontNamed: "Copperplate-Bold")
    
    private var score : Int = -0
    {
        didSet
        {
            scoreNode.text = "Current Score: \(score)"
        }
    }
    
    //MARK: - END THE GAME
    private func endGame() -> Void
    {
        let transition = SKTransition.fade(with: .green, duration: 5)
        let endScene = EndGameScene()
        endScene.score = score
        endScene.size = CGSize(width: 300, height: 500)
        endScene.scaleMode = .fill
        self.view?.presentScene(endScene, transition: transition)
    }
    
    override func didMove(to view : SKView) -> Void
    {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        //Add scoreLabel
        scoreNode.zPosition = 2
        scoreNode.position.x = 120
        scoreNode.position.y = 480
        scoreNode.fontSize = 20
        addChild(scoreNode)
        score = 0
        
        //MARK: Load background music
        let backgroundMusic = SKAudioNode(fileNamed: "TheBlindNavigator")
        backgroundMusic.name = "music"
        addChild(backgroundMusic)
    }
    
    override func touchesBegan(_ touches : Set<UITouch>, with event : UIEvent?) -> Void
    {
        guard let touch = touches.first
        else { return }
        
        if (score >= 100)
        {
            endGame()
        }
        else
        {
            let currentColor = assignColorAndBitmask()
            let width = Int(arc4random() % 50)
            let height = Int(arc4random() % 50)
            let location = touch.location(in: self)
            
            let node : SKSpriteNode
            node = SKSpriteNode(color: currentColor, size: CGSize(width: width, height: height))
            
            node.position = location
            node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            node.physicsBody?.contactTestBitMask = UInt32(colorMask)
            
            addChild(node)
        }
    }
    
    private func assignColorAndBitmask() -> UIColor
    {
        let colors : [UIColor] = [.black, .red, .magenta, .blue, .green, .darkGray, .cyan, .brown, .yellow]
        let randomIndex = Int(arc4random()) % colors.count
        
        colorMask = randomIndex + 1
        
        return colors[randomIndex]
    }
    
    //MARK: Collisin Sequence
    
    func didBegin(_ contact: SKPhysicsContact) -> Void
    {
        guard let first = contact.bodyA.node else { return }
        guard let second = contact.bodyB.node else { return }
        
        collisionBetween(first, and: second)
    }
    
    private func collisionBetween(_ nodeOne : SKNode, and nodeTwo : SKNode) -> Void
    {
        if (nodeOne.physicsBody?.contactTestBitMask == nodeTwo.physicsBody?.contactTestBitMask)
        {
            annihilate(deadNode: nodeOne)
            annihilate(deadNode: nodeTwo)
        }
    }
    
    private func annihilate(deadNode : SKNode) -> Void
    {
        score += 5
        explosionEffect(at: deadNode.position)
        updateSound()
        deadNode.removeFromParent()
    }
    
    //MARK: - Kaboom?
    
    private func explosionEffect(at location : CGPoint) -> Void
    {
        if let explosion = SKEmitterNode(fileNamed: "SparkParticle")
        {
            explosion.position = location
            addChild(explosion)
            
            let waitTime = SKAction.wait(forDuration: 5)
            let removeExplosion = SKAction.removeFromParent()
            let reverbChange = SKAction.changeReverb(to: 1.0, duration: 2.0)
            let speedChange = SKAction.changePlaybackRate(to: 1.2, duration: 2.0)
            let explosiveSequence = SKAction.sequence([speedChange, reverbChange, waitTime, removeExplosion])
            
            let effectSound = SKAction.playSoundFileNamed("drop bass", waitForCompletion: false)
            run(effectSound)
            
            explosion.run(explosiveSequence)
        }
    }
    
    //MARK: - Sound effect
    private func updateSound() -> Void
    {
        if let sound = childNode(withName: "music")
        {
            let speedUp = SKAction.changePlaybackRate(by: 1.5, duration: 0.01)
            let reverbChange = SKAction.changeReverb(to: 1.0, duration: 5.0)
            sound.run(reverbChange)
            sound.run(speedUp)
        }
    }
}
