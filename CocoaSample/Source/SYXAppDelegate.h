//
//  SYXAppDelegate.h
//  CocoaSample
//
//   by Shen Yixin on 13-12-17.
//
//

#import <Cocoa/Cocoa.h>

@class SYXTextLink;
@class SYXThreePartButton;
@class SYXBaseTableViewWndCtrl;

@interface SYXAppDelegate : NSObject <NSApplicationDelegate>
{
    SYXTextLink *_textLink;
    SYXThreePartButton *_threePartButton;
    SYXBaseTableViewWndCtrl *_baseTableViewWndCtrl;
    
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet SYXTextLink *textLink;
@property (retain) IBOutlet SYXThreePartButton *threePartButton;
@property (retain) IBOutlet SYXBaseTableViewWndCtrl *baseTableViewWndCtrl;


- (IBAction)baseTableViewClicked:(id)sender;


@end
