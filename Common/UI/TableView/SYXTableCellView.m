//
//  SYXTableCellView.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "SYXTableCellView.h"

@implementation SYXTableCellView

//changing the selected text field cell’s text color 
-(void)setBackgroundStyle:(NSBackgroundStyle)style {
    if (style == NSBackgroundStyleLight) {
        [self.textField.cell setTextColor:[NSColor controlTextColor]];
        
    } else {
        [self.textField.cell setTextColor:[NSColor redColor]];
        
    }
    [super setBackgroundStyle:style];
}
@end
