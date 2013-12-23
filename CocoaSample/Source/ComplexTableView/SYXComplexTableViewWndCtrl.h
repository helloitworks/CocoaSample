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
    
    NSArray *_selectedObjects;

}

@property (retain) NSMutableArray *tableContents;
@property (retain) IBOutlet NSTableView *tableView;;
@property (retain) IBOutlet NSTextField *lblMsg;;
@property (nonatomic, readonly) BOOL showRevealInFinderMenuItem;
@property(nonatomic, assign) NSArray *selectedObjects;


- (IBAction)btnRevealClicked:(id)sender;
- (IBAction)btnRemoveClicked:(id)sender;

- (IBAction)menuRevealClicked:(id)sender;
- (IBAction)menuRemoveRowClicked:(id)sender;


@end
