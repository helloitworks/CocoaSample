//
//  SYXTextFieldWithRedColor.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-19.
//
//

#import "SYXTextFieldWithRedColor.h"

@implementation SYXTextFieldWithRedColor

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.stringValue attributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSColor redColor], NSForegroundColorAttributeName,nil]];
    self.attributedStringValue = attributedString;
    
    /*
     NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"attributed String" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:14],NSFontAttributeName,[NSColor redColor], NSForegroundColorAttributeName,nil]];
     //attributedString setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName
     */
    
	[super drawRect:dirtyRect];
    // Drawing code here.
}

@end
