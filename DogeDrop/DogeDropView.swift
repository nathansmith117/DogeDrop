//
//  DogeDropView.swift
//  DogeDrop
//
//  Created by Smith, Nathanael on 11/13/23.
//

import SwiftUI
import SpriteKit

struct DogeDropView: View
{
    let width : CGFloat = 300
    let height : CGFloat = 500
    
    private var simpleScene : GameScene
    {
        let scene = GameScene()
        scene.size = CGSize(width: width, height: height)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View
    {
        VStack
        {
            Text("Doge Drop")
            SpriteView(scene: simpleScene)
                .frame(width: width, height: height)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview
{
    DogeDropView()
}
