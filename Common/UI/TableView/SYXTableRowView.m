//
//  SYXTableRowView.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "SYXTableRowView.h"

@implementation SYXTableRowView




#pragma mark - separator
-(void) drawSeparatorInRect:(NSRect)dirtyRect {
    NSColor *color = [NSColor colorWithCalibratedRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0];
    [color set];
    NSRect separatorRect = NSMakeRect(0,0, NSWidth(dirtyRect), 20);
    NSBezierPath *separatorPath = [NSBezierPath bezierPathWithRect:separatorRect];
    [separatorPath fill];
}

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        NSRect selectionRect = self.bounds;
        selectionRect.size.height = self.bounds.size.height;
        [[NSColor colorWithDeviceRed:217/255.0f green:236/255.0f blue:255/255.0f alpha:1.0] setFill];
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:selectionRect];
        [selectionPath fill];
    }
}



- (NSBackgroundStyle)interiorBackgroundStyle {
    return NSBackgroundStyleLight;
}


@end
