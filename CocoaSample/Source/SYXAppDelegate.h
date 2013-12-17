//
//  SYXAppDelegate.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-17.
//
//

#import <Cocoa/Cocoa.h>

@class SYXTextLink;
@class SYXThreePartButton;
@interface SYXAppDelegate : NSObject <NSApplicationDelegate>
{
    SYXTextLink *_textLink;
    SYXThreePartButton *_threePartButton;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet SYXTextLink *textLink;
@property (retain) IBOutlet SYXThreePartButton *threePartButton;


@end
