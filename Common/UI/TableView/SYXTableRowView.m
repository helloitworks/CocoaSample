//
//  SYXTableRowView.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "SYXTableRowView.h"



@implementation SYXTableRowView

#pragma mark - background

- (void)drawBackgroundInRect:(NSRect)dirtyRect
{
    NSRect selectionRect = self.bounds;
    selectionRect.size.height = self.bounds.size.height;
    [[NSColor colorWithDeviceRed:217/255.0f green:236/255.0f blue:255/255.0f alpha:1.0] setFill];
    NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:selectionRect];
    [selectionPath fill];
}

#pragma mark - selection
- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        NSRect selectionRect = self.bounds;
        selectionRect.size.height = self.bounds.size.height;
        [[NSColor colorWithDeviceRed:217/255.0f green:236/255.0f blue:255/255.0f alpha:1.0] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:selectionRect];
        [selectionPath fill];
    }
}

#pragma mark - separator
-(void) drawSeparatorInRect:(NSRect)dirtyRect {
    NSColor *color = [NSColor colorWithCalibratedRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0];
    [color set];
    NSRect separatorRect = NSMakeRect(0,0, NSWidth(dirtyRect), 1);
    NSBezierPath *separatorPath = [NSBezierPath bezierPathWithRect:separatorRect];
    [separatorPath fill];
}




// SYXTableCellView的background style一直返回NSBackgroundStyleLight，直到有鼠标点击某一行。
// 如果都是hover或者调用selectRowIndexes，而没有鼠标点击，这里通过判断self.selected返回相应的background style，从而SYXTableCellView可以得到不同的background style来绘制不同的文字颜色
//- (NSBackgroundStyle)interiorBackgroundStyle
//{
//    if (self.selected)
//    {
//        return NSBackgroundStyleDark;
//    }
//    else
//    {
//        return NSBackgroundStyleLight;
//    }
//}



@end
