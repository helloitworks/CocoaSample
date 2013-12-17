//
//  SYXCommonUI.m
//  CocoaSample
//
//  Created by shenyixin on 13-12-17.
//
//

#import "SYXCommonUI.h"

@implementation SYXCommonUI
+(NSPoint)calcOriginalForCenterDraw:(NSSize)drawSize destRect:(NSRect)destRect
{
    NSPoint point = [self calcOriginalForCenterDraw:drawSize destSize:destRect.size];
    point.x += destRect.origin.x;
    point.y += destRect.origin.y;
    return point;
}

+(NSPoint)calcOriginalForCenterDraw:(NSSize)drawSize destSize:(NSSize)destSize
{
    NSPoint point = NSZeroPoint;
    point.x += (destSize.width - drawSize.width) / 2;
    point.y += (destSize.height - drawSize.height) / 2;
    return point;
}
@end
