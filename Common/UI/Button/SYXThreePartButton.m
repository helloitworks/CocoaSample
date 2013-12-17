//
//  TSThreePartButton.m
//  Thunder
//
//  Created by Shen Yixin on 13-12-6.


#import "SYXThreePartButton.h"

@implementation SYXThreePartButton
@synthesize firstImage = _firstImage;
@synthesize secondeImage = _secondeImage;
@synthesize thirdImage = _thirdImage;
@synthesize firstImagePress = _firstImagePress;
@synthesize secondeImagePress = _secondeImagePress;
@synthesize thirdImagePress = _thirdImagePress;
@synthesize firstImageHover = _firstImageHover;
@synthesize secondeImageHover = _secondeImageHover;
@synthesize thirdImageHover = _thirdImageHover;



- (void)updateTrackingAreas
{
	[super updateTrackingAreas];
	
	if (_trackArea)
	{
		[self removeTrackingArea:_trackArea];
		[_trackArea release];
	}
	
    _trackArea = [[NSTrackingArea alloc] initWithRect: [self bounds]
                                              options: NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp | NSTrackingInVisibleRect | NSTrackingCursorUpdate
                                                owner: self
                                             userInfo: nil];
    [self addTrackingArea: _trackArea];
}


- (void)drawRect:(NSRect)dirtyRect
{
    if(self.state == NSOnState)
    {
        if(_firstImagePress && _secondeImagePress && _thirdImagePress)
        {
            NSDrawThreePartImage(self.bounds, _firstImagePress, _secondeImagePress, _thirdImagePress, NO, NSCompositeSourceOver, 1., YES);
        }
    }
    else if(_isHorver)
    {
        if(_firstImageHover && _secondeImageHover && _thirdImageHover)
        {
            NSDrawThreePartImage(self.bounds, _firstImageHover, _secondeImageHover, _thirdImageHover, NO, NSCompositeSourceOver, 1., YES);
        }
    }

    else
    {
        if(_firstImage && _secondeImage && _thirdImage)
        {
            NSDrawThreePartImage(self.bounds, _firstImage, _secondeImage, _thirdImage, NO, NSCompositeSourceOver, 1., YES);
        }
    }
    static NSDictionary* sTitleAttribute = nil;
    if(nil == sTitleAttribute)
    {
        sTitleAttribute = [[NSDictionary dictionaryWithObjectsAndKeys:[self font],NSFontAttributeName, nil] retain];
    }
    NSSize size = [[self title] sizeWithAttributes:sTitleAttribute];
    NSPoint titlePoint = [SYXCommonUI calcOriginalForCenterDraw:size destSize:self.bounds.size];
    
    NSRect drawRect = {titlePoint, size};
    [[self title] drawInRect:drawRect withAttributes:sTitleAttribute];
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    _isHorver = YES;
    [super mouseEntered:theEvent];
    [self setNeedsDisplay:YES];
}
-(void)mouseExited:(NSEvent *)theEvent
{
    _isHorver = NO;
    [super mouseExited:theEvent];
    [self setNeedsDisplay:YES];

}

-(void)mouseDown:(NSEvent *)theEvent
{
    self.state = NSOnState;
    [self display];
    [super mouseDown:theEvent];
    self.state = NSOffState;
    [self display];
    
}

-(void)dealloc
{
    self.firstImage = nil;
    self.secondeImage = nil;
    self.thirdImage = nil;
    self.firstImagePress = nil;
    self.secondeImagePress = nil;
    self.thirdImagePress = nil;
    [super dealloc];
}
@end
