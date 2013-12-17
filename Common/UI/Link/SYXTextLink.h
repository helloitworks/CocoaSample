//
//  TextLink.h
//  SYXTextLink
//
//  Created by Shen Yixin on 13-7-25.
//
//

#import <Cocoa/Cocoa.h>

@interface SYXTextLink : NSView
{
    NSTrackingArea* _trackArea;
    NSString* _title;
    BOOL _isInArea;
    BOOL _isPress;
    
    id _target;
    SEL _selector;
}

@property (retain) NSString* title;
@property (assign) id target;
@property (assign) SEL selector;

@end
