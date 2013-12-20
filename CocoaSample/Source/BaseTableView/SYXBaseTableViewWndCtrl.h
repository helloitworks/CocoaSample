//
//  SYXBaseTableViewWndCtrl.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-19.
//
//

#import <Cocoa/Cocoa.h>

@interface SYXBaseTableViewWndCtrl : NSWindowController <NSTableViewDataSource, NSTableViewDelegate>
{
    NSMutableArray *_tableContents;
    NSTableView *_tableView;
    NSTextField *_lblMsg;
}

@property (retain) NSMutableArray *tableContents;
@property (retain) IBOutlet NSTableView *tableView;;
@property (retain) IBOutlet NSTextField *lblMsg;;

- (IBAction)btnRunClicked:(id)sender;
- (IBAction)chkRowChecked:(id)sender;
- (IBAction)chkAllChecked:(id)sender;

@end
