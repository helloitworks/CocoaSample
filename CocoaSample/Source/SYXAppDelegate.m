//
//  SYXAppDelegate.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-17.
//
//

#import "SYXAppDelegate.h"
#import "UI.h"
#import "SYXBaseTableViewWndCtrl.h"
@implementation SYXAppDelegate
@synthesize textLink = _textLink;
@synthesize threePartButton = _threePartButton;
@synthesize baseTableViewWndCtrl = _baseTableViewWndCtrl;

NSString *const SYXTextLinkUrl = @"http://www.helloitworks.com";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[SYXLogger sharedInstance] setFilePathName:@"/tmp/CocoaSample.log"];    
}
- (void)awakeFromNib
{
    self.textLink.title = SYXTextLinkUrl;
    self.textLink.target = self;
    self.textLink.selector = @selector(onTextLink:);
    //[self.textLink setNeedsDisplay:YES];
    
    self.threePartButton.title = @"下载";
    self.threePartButton.font = [NSFont systemFontOfSize:11];

    self.threePartButton.firstImage = [NSImage imageNamed:@"DownloadMgrOpenL"];
    self.threePartButton.secondeImage = [NSImage imageNamed:@"DownloadMgrOpenF"];
    self.threePartButton.thirdImage = [NSImage imageNamed:@"DownloadMgrOpenR"];
    
    self.threePartButton.firstImagePress = [NSImage imageNamed:@"DownloadMgrOpenPressL"];
    self.threePartButton.secondeImagePress = [NSImage imageNamed:@"DownloadMgrOpenPressF"];
    self.threePartButton.thirdImagePress = [NSImage imageNamed:@"DownloadMgrOpenPressR"];
    
    self.threePartButton.firstImageHover = [NSImage imageNamed:@"DownloadMgrOpenHLL"];
    self.threePartButton.secondeImageHover = [NSImage imageNamed:@"DownloadMgrOpenHLF"];
    self.threePartButton.thirdImageHover = [NSImage imageNamed:@"DownloadMgrOpenHLR"];
}

- (IBAction)onTextLink:(id)sender
{
    NSString* strUrl = SYXTextLinkUrl;
    NSURL *url = [[[NSURL alloc] initWithString:strUrl] autorelease];
    [[NSWorkspace sharedWorkspace] openURL:url];
    
}
- (IBAction)baseTableViewClicked:(id)sender
{
    if (self.baseTableViewWndCtrl == nil) {
        self.baseTableViewWndCtrl = [[SYXBaseTableViewWndCtrl alloc] init];
    }
    [self.baseTableViewWndCtrl showWindow:self];
}
@end
