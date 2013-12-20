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
@class SYXComplexTableViewWndCtrl;

@interface SYXAppDelegate : NSObject <NSApplicationDelegate>
{
    SYXTextLink *_textLink;
    SYXThreePartButton *_threePartButton;
    SYXBaseTableViewWndCtrl *_baseTableViewWndCtrl;
    SYXComplexTableViewWndCtrl *_complexTableViewWndCtrl;
}

@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet SYXTextLink *textLink;
@property (retain) IBOutlet SYXThreePartButton *threePartButton;
@property (retain) IBOutlet SYXBaseTableViewWndCtrl *baseTableViewWndCtrl;
@property (retain) IBOutlet SYXComplexTableViewWndCtrl *complexTableViewWndCtrl;


- (IBAction)btnBaseTableViewClicked:(id)sender;
- (IBAction)btnComplexTableViewClicked:(id)sender;

@end
