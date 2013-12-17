//
//  SYXCommonUI.h
//  CocoaSample
//
//  Created by shenyixin on 13-12-17.
//
//

#import <Foundation/Foundation.h>

@interface SYXCommonUI : NSObject
+(NSPoint)calcOriginalForCenterDraw:(NSSize)drawSize destRect:(NSRect)destRect;
+(NSPoint)calcOriginalForCenterDraw:(NSSize)drawSize destSize:(NSSize)destSize;

@end
