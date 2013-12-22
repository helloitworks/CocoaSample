//
//  SYXComplexTableCellView.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import "SYXComplexTableCellView.h"

@implementation SYXComplexTableCellView
@synthesize lblVersion = _lblVersion;
@synthesize btnReveal = _btnReveal;
@synthesize btnRemove = _btnRemove;

- (void)awakeFromNib
{
    [self.lblVersion sizeToFit];
}

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
        //[_btnVod setHidden:![(SniffedTaskItem *)self.objectValue canVod]];
        [self.btnReveal setHidden:NO];
    } else {
        [self.btnReveal setHidden:YES];
    }
    
}

- (void)dealloc
{
    [_trackingArea release];
    [super dealloc];
}


@end
