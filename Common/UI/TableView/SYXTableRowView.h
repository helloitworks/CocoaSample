//
//  SYXTableRowView.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import <Cocoa/Cocoa.h>

@interface SYXTableRowView : NSTableRowView
{
    BOOL _mouseInside;
    NSTrackingArea *_trackingArea;
}

@property (assign) BOOL mouseInside;
@end
