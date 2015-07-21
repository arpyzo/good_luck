//
//  GoodLuckViewController.swift
//  Good Luck
//
//  Created by Robert Pyzalski on 6/27/15.
//  Copyright (c) 2015 Robert Pyzalski. All rights reserved.
//

import Foundation
import GLKit

class GameViewController: GLKViewController {
    var context: EAGLContext?
    var effect: GLKBaseEffect?
    var player: Sprite?
    
    var gameView: GLKView {
        return self.view as! GLKView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = EAGLContext(API: .OpenGLES2)
        assert(self.context != nil, "Failed to create OpenGL ES 2.0 context")
        self.gameView.context = self.context
        EAGLContext.setCurrentContext(self.context)

        self.effect = GLKBaseEffect()
        self.effect!.transform.projectionMatrix = GLKMatrix4MakeOrtho(0, 667, 0, 375, -1024, 1024)
        
        self.player = Sprite("Player.png", self.effect!)
    }
    
    override func glkView(view: GLKView, drawInRect rect: CGRect) {
        glClearColor(1, 1, 1, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        glEnable(GLuint(GL_BLEND))
        
        self.player!.render()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}