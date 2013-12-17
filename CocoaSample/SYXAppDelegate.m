//
//  SYXAppDelegate.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-17.
//
//

#import "SYXAppDelegate.h"
#import "UI.h"
@implementation SYXAppDelegate
@synthesize textLink = _textLink;

NSString *const SYXTextLinkUrl = @"http://www.helloitworks.com";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
- (void)awakeFromNib
{
    self.textLink.title = SYXTextLinkUrl;
    self.textLink.target = self;
    self.textLink.selector = @selector(onTextLink:);
    
    //[self.textLink setNeedsDisplay:YES];
}

- (IBAction)onTextLink:(id)sender
{
    NSString* strUrl = SYXTextLinkUrl;
    NSURL *url = [[[NSURL alloc] initWithString:strUrl] autorelease];
    [[NSWorkspace sharedWorkspace] openURL:url];
    
}
@end
