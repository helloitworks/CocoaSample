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

- (IBAction)btnRevealClicked:(id)sender;
- (IBAction)menuRevealClicked:(id)sender;
- (IBAction)btnRemoveClicked:(id)sender;
- (IBAction)menuRemoveRowClicked:(id)sender;


@end
