//
//  SYXAppDelegate.h
//  CocoaSample
//
//  Created by shenyixin on 13-12-17.
//
//

#import <Cocoa/Cocoa.h>

@class SYXTextLink;

@interface SYXAppDelegate : NSObject <NSApplicationDelegate>
{
    SYXTextLink *_textLink;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet SYXTextLink *textLink;


@end
