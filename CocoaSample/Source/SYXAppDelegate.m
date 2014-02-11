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
#import "SYXComplexTableViewWndCtrl.h"

@implementation SYXAppDelegate
@synthesize textLink = _textLink;
@synthesize threePartButton = _threePartButton;
@synthesize baseTableViewWndCtrl = _baseTableViewWndCtrl;
@synthesize complexTableViewWndCtrl = _complexTableViewWndCtrl;

NSString *const SYXTextLinkUrl = @"http://www.helloitworks.com";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[SYXLogger sharedInstance] setFilePathName:@"/tmp/CocoaSample.log"];
    LOG_DEBUG(@"it is a test");
    [self fileNotifications];
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

//--------sleep notification
- (void) receiveSleepNote: (NSNotification*) note
{
    LOG_DEBUG(@"receiveSleepNote: %@", [note name]);
}

- (void) receiveWakeNote: (NSNotification*) note
{
    LOG_DEBUG(@"receiveWakeNote: %@", [note name]);
}

- (void) fileNotifications
{
    //These notifications are filed on NSWorkspace's notification center, not the default
    // notification center. You will not receive sleep/wake notifications if you file
    //with the default notification center.
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveSleepNote:)
                                                               name: NSWorkspaceWillSleepNotification object: NULL];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveWakeNote:)
                                                               name: NSWorkspaceDidWakeNotification object: NULL];
}



- (IBAction)onTextLink:(id)sender
{
    NSString* strUrl = SYXTextLinkUrl;
    NSURL *url = [[[NSURL alloc] initWithString:strUrl] autorelease];
    [[NSWorkspace sharedWorkspace] openURL:url];
    
}
- (IBAction)btnBaseTableViewClicked:(id)sender
{
    if (self.baseTableViewWndCtrl == nil) {
        self.baseTableViewWndCtrl = [[SYXBaseTableViewWndCtrl alloc] init];
    }
    [self.baseTableViewWndCtrl showWindow:self];
}

- (IBAction)btnComplexTableViewClicked:(id)sender
{
    if (self.complexTableViewWndCtrl == nil) {
        self.complexTableViewWndCtrl = [[SYXComplexTableViewWndCtrl alloc] init];
    }
    [self.complexTableViewWndCtrl showWindow:self];
}

@end
