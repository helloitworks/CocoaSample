//
//  SYXAppDelegate.m
//  CocoaSample
//
//  Created by shenyixin on 13-12-17.
//
//

#import "SYXAppDelegate.h"
#import "UI.h"
@implementation SYXAppDelegate
@synthesize textLink = _textLink;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
- (void)awakeFromNib
{
    self.textLink.title = @"http://www.helloitworks.com";
    self.textLink.target = self;
    self.textLink.selector = @selector(onTextLink:);
    
    //[self.textLink setNeedsDisplay:YES];
}

- (IBAction)onTextLink:(id)sender
{
    NSString* strUrl = @"http://www.helloitworks.com";
    NSURL *url = [[[NSURL alloc] initWithString:strUrl] autorelease];
    [[NSWorkspace sharedWorkspace] openURL:url];
    
}
@end
