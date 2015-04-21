//
//  GameLoop.swift
//  Anim1
//
//  Created by Lucas Caballero on 3/23/15.
//  Copyright (c) 2015 Cool Kid Luke. All rights reserved.
//

import UIKit

class GameLoop : NSObject {

    var doSomething: () -> ()!
    var displayLink: CADisplayLink!
    
    init(doSomething: () -> ()) {
        self.doSomething = doSomething
        super.init()
        start()
    }
    
    func handleTimer() {
        doSomething()
    }
    
    func start() {
        displayLink = CADisplayLink(target: self, selector: Selector("handleTimer"))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func stop() {
        displayLink.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        displayLink = nil
    }
}
