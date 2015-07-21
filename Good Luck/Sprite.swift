//
//  Sprite.swift
//  Good Luck
//
//  Created by Robert Pyzalski on 6/28/15.
//  Copyright (c) 2015 Robert Pyzalski. All rights reserved.
//

import Foundation
import GLKit

class Sprite {
    struct GLVertex {
        var x: GLfloat
        var y: GLfloat
        init(_ x: GLfloat, _ y: GLfloat) {
            self.x = x
            self.y = y
        }
    }
    
    var geometryArray = [GLVertex]()
    var textureArray = [GLVertex]()
    
    var effect: GLKBaseEffect
    var textureInfo: GLKTextureInfo?
    
    init(_ filename: String, _ effect: GLKBaseEffect) {
        self.effect = effect
        
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: nil)
        let options = [GLKTextureLoaderOriginBottomLeft : NSNumber(bool: true)]
        var error: NSError? = nil
        
        self.textureInfo = GLKTextureLoader.textureWithContentsOfFile(path, options: options, error: &error)
        if (self.textureInfo == nil) {
            NSLog("Error loading file in sprite: %@", error!);
        }
        
        geometryArray.append(GLVertex(0,                                0))                                    // Bottom left
        geometryArray.append(GLVertex(GLfloat(self.textureInfo!.width), 0))                                    // Bottom right
        geometryArray.append(GLVertex(0,                                GLfloat(self.textureInfo!.height)))    // Top left
        geometryArray.append(GLVertex(GLfloat(self.textureInfo!.width), GLfloat(self.textureInfo!.height)))    // Top right
        
        textureArray.append(GLVertex(0, 0))    // Bottom left
        textureArray.append(GLVertex(1, 0))    // Bottom right
        textureArray.append(GLVertex(0, 1))    // Top left
        textureArray.append(GLVertex(1, 1))    // Top right
    }
    
    func render() {
        self.effect.texture2d0.name = self.textureInfo!.name
        self.effect.texture2d0.enabled = GLboolean(GL_TRUE)
        self.effect.prepareToDraw()
        
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.Position.rawValue))
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.TexCoord0.rawValue))
        
        withUnsafePointer(&geometryArray[0]) { (pointer) -> Void in
            glVertexAttribPointer(GLuint(GLKVertexAttrib.Position.rawValue),
                2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(0), pointer)
        }
        withUnsafePointer(&textureArray[0]) { (pointer) -> Void in
            glVertexAttribPointer(GLuint(GLKVertexAttrib.TexCoord0.rawValue),
                2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(0), pointer)
        }
        
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
}