//
//  SYXComplexTableCellView.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import <Cocoa/Cocoa.h>

@interface SYXComplexTableCellView : NSTableCellView
{
    NSTextField *_lblVersion;
    NSTextField *_lblPath;

    NSButton *_btnReveal;
    NSButton *_btnRemove;
    
    BOOL _mouseInside;
    NSTrackingArea *_trackingArea;
}

@property (retain) IBOutlet NSTextField *lblVersion;
@property (retain) IBOutlet NSTextField *lblPath;

@property (retain) IBOutlet NSButton *btnReveal;
@property (retain) IBOutlet NSButton *btnRemove;

@end
