//
//  SYXTableRowView.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import <Cocoa/Cocoa.h>
/*
 This class is used because the NIB has an SYXTableRowView placed in it with a special key of NSTableViewRowViewKey. NSTableView first looks for a view with that key for the row view, if the delegate method tableView:rowViewForRow: is not used.
 */

@interface SYXTableRowView : NSTableRowView
{
    BOOL _mouseInside;
    NSTrackingArea *_trackingArea;
}

@property (assign) BOOL mouseInside;
@end
