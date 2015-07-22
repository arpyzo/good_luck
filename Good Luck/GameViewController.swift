// Copyright (c) 2015 Robert Pyzalski
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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