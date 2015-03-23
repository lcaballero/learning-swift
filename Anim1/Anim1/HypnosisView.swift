//
//  HypnosisView.swift
//  Anim1
//
//  Created by Lucas Caballero on 3/22/15.
//  Copyright (c) 2015 Cool Kid Luke. All rights reserved.
//

import UIKit
import Darwin

let PI = M_PI
let _2PI = 2 * PI

class HypnosisView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init(coder: NSCoder) {
        super.init(coder: NSCoder())
    }

    override func drawRect(rect: CGRect) {
        var bounds : CGRect = self.window!.bounds
        
        let x = (bounds.origin.x + bounds.size.width) / 2
        let y = (bounds.origin.y + bounds.size.height) / 2
        var center = CGPointMake(x, y)
        
        var maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
        
        var path = UIBezierPath()
        path.lineWidth = 10
        UIColor.lightGrayColor().setStroke()
        
        for var radius = maxRadius; radius > 0; radius -= 20.0 {
            path.moveToPoint(CGPointMake(center.x + radius, center.y))
            path.addArcWithCenter(
                center,
                radius: radius,
                startAngle: 0,
                endAngle: CGFloat(_2PI),
                clockwise: true)
            
            
            path.stroke()
        }
        
        drawGradient(bounds)
        drawImage(bounds)
    }
    
    func drawGradient(bounds: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        let locations : [CGFloat] = [ 0.0, 1.0 ]
        let components : [CGFloat] = [
            1.0, 0.0, 0.0, 1.0,
            1.0, 1.0, 0.0, 1.0
        ]
        let area = imageArea(bounds)
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2)
        
        let start = CGPointMake(area.origin.x + area.size.width / 2, area.origin.y)
        let end = CGPointMake(area.origin.x + area.size.width / 2, area.origin.y + area.size.height)
        
        let options : CGGradientDrawingOptions = UInt32(kCGGradientDrawsBeforeStartLocation) | UInt32(kCGGradientDrawsAfterEndLocation)
        
        let path = UIBezierPath()
        
        path.moveToPoint(start)
        path.addLineToPoint(CGPointMake(area.origin.x + area.size.width, area.origin.y + area.size.height))
        path.addLineToPoint(CGPointMake(area.origin.x, area.origin.y + area.size.height))
        path.addLineToPoint(CGPointMake(area.origin.x + area.size.width / 2, area.origin.y))
        
        path.addClip()

        CGContextDrawLinearGradient(context, gradient, start, end, options)
        CGContextRestoreGState(context)
    }
    
    func imageArea(bounds:CGRect) -> CGRect {
        let w = bounds.width * 0.5
        let h = bounds.height * 0.5
        
        let x = (bounds.width - w) / 2
        let y = (bounds.height - h) / 2
        
        var area = CGRectMake(x, y, w, h)
 
        return area;
    }
    
    func drawImage(bounds: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextSetShadow(context, CGSizeMake(4,7), 3)
        
        var image = UIImage(named:"logo.png")
        let area = imageArea(bounds)
        image?.drawInRect(area)
        
        CGContextRestoreGState(context)
    }
}