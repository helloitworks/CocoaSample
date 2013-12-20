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
    NSTextField *_version;
}

@property (retain) IBOutlet NSTextField *version;
@end
