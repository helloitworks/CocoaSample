//
//  SYXComplexTableViewWndCtrl.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import <Cocoa/Cocoa.h>

@interface SYXComplexTableViewWndCtrl : NSWindowController
{
    NSMutableArray *_tableContents;
    NSTableView *_tableView;
    NSTextField *_lblMsg;
}

@property (retain) NSMutableArray *tableContents;
@property (retain) IBOutlet NSTableView *tableView;;
@property (retain) IBOutlet NSTextField *lblMsg;;

- (IBAction)btnRemoveClicked:(id)sender;
- (IBAction)btnRevealClicked:(id)sender;

@end
