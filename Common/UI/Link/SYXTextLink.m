//
//  TextLink.m
//  SYXTextLink
//
//  Created by Shen Yixin on 13-7-25.
//
//

#import "SYXTextLink.h"

#define FONT_COLOR_RED      76.f
#define FONT_COLOR_GREEN    76.f
#define FONT_COLOR_BLUE     76.f

@implementation SYXTextLink

@synthesize title = _title;
@synthesize target = _target;
@synthesize selector = _selector;

- (id)initWithFrame: (NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _trackArea = [[NSTrackingArea alloc] initWithRect: [self bounds]
                                                  options: NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp | NSTrackingInVisibleRect | NSTrackingCursorUpdate
                                                    owner: self
                                                 userInfo: nil];
        [self addTrackingArea: _trackArea];
    }
    return self;
}

- (void)mouseDown: (NSEvent *)theEvent
{
    _isPress = YES;
}

- (void)mouseUp: (NSEvent *)theEvent
{
    if (_isPress)
    {
        NSPoint location = [self convertPoint: [theEvent locationInWindow] fromView: nil];
        if (NSPointInRect(location, [self bounds]))
        {
            if (_target && [_target respondsToSelector: _selector])
            {
                [_target performSelector: _selector withObject: self];
            }
        }
    }
}

- (void)cursorUpdate:(NSEvent *)event
{
    [[NSCursor pointingHandCursor] push];
}

- (void)mouseEntered: (NSEvent *)theEvent
{
    _isInArea = YES;
    [self setNeedsDisplay: YES];
}

- (void)mouseExited: (NSEvent *)theEvent
{
    _isInArea = NO;
    [self setNeedsDisplay: YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (_title != nil)
    {
        NSColor* fontColor = [NSColor blueColor];
        NSMutableAttributedString* title = [[[NSMutableAttributedString alloc] initWithString: _title] autorelease];
        NSRange range = NSMakeRange(0, [title length]);
        [title addAttribute: NSForegroundColorAttributeName value: fontColor range: range];
        if (_isInArea)
        {
            [title addAttribute: NSUnderlineStyleAttributeName value: [NSNumber numberWithInteger: 1] range: range];
        }
        [title drawInRect: [self bounds]];
    }
}

- (void)dealloc
{
    [_trackArea release];
    [_title release];
    [super dealloc];
}

@end
