//
//  SYXTableRowView.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "SYXTableRowView.h"

@implementation SYXTableRowView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}



#pragma mark - separator
-(void) drawSeparatorInRect:(NSRect)dirtyRect {
    NSColor *color = [NSColor colorWithCalibratedRed:232/255.0f green:235/255.0f blue:237/255.0f alpha:1.0];
    [color set];
    NSRect separatorRect = NSMakeRect(0,0, NSWidth(dirtyRect), 1);
    NSBezierPath *separatorPath = [NSBezierPath bezierPathWithRect:separatorRect];
    [separatorPath fill];
}

- (NSBackgroundStyle)interiorBackgroundStyle {
    return NSBackgroundStyleLight;
}

#pragma mark - hover color
- (void) createTrackingArea
{
    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    _trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                  options:opts
                                                    owner:self
                                                 userInfo:nil];
    [self addTrackingArea:_trackingArea];
    
    NSPoint mouseLocation = [[self window] mouseLocationOutsideOfEventStream];
    mouseLocation = [self convertPoint: mouseLocation
                              fromView: nil];
    
    if (CGRectContainsPoint(NSRectToCGRect([self bounds]),NSPointToCGPoint(mouseLocation)))
    {
        [self mouseEntered: nil];
    }
    else
    {
        [self mouseExited: nil];
    }
}

//bugfix:mouseExited/mouseEntered isn't called when mouse exits from NStrackingArea by scrolling or doing animation
- (void)updateTrackingAreas {
    [self removeTrackingArea:_trackingArea];
    [self createTrackingArea];
    [super updateTrackingAreas];
    
}

- (void)setMouseInside:(BOOL)value {
    if (_mouseInside != value) {
        _mouseInside = value;
        [self setNeedsDisplay:YES];
    }
}
- (BOOL)mouseInside {
    return _mouseInside;
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.mouseInside = YES;
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.mouseInside = NO;
}
- (void)drawRect:(NSRect)dirtyRect
{
    if (self.mouseInside) {
        //画背景
        NSRect selectionRect = self.bounds;
        selectionRect.size.height = self.bounds.size.height-1;
        [[NSColor whiteColor] setStroke];
        [[NSColor colorWithSRGBRed:217/255.0f green:240/255.0f blue:255/255.0f alpha:1.0] setFill]; //#d9foff
        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:selectionRect];
        [selectionPath fill];
        [selectionPath stroke];
        //[_btnVod setHidden:![(SniffedTaskItem *)self.objectValue canVod]];
        //[_btnDownload setHidden:NO];
    } else {
        //[_btnVod setHidden:YES];
        //[_btnDownload setHidden:YES];
    }
    
}

- (void)dealloc
{
    [_trackingArea release];
    [super dealloc];
}

@end
