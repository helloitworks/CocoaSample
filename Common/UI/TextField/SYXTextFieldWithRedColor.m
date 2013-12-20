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

- (void)awakeFromNib
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedStringValue]];
    NSRange range = NSMakeRange(0, self.stringValue.length);
    [attString addAttribute:NSForegroundColorAttributeName value:[NSColor redColor] range:range];
    self.attributedStringValue = attString;
    /*
     NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"attributed String" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:14],NSFontAttributeName,[NSColor redColor], NSForegroundColorAttributeName,nil]];
     //attributedString setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName
     */
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    // Drawing code here.
}

@end
