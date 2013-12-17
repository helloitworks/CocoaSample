//
//  TSThreePartButton.h
//  Thunder
//
//  Created by Shen Yixin on 13-12-6.


#import <Cocoa/Cocoa.h>

@interface SYXThreePartButton : NSButton
{
    NSImage* _firstImage;
    NSImage* _secondeImage;
    NSImage* _thirdImage;
    NSImage* _firstImagePress;
    NSImage* _secondeImagePress;
    NSImage* _thirdImagePress;
    NSImage* _firstImageHover;
    NSImage* _secondeImageHover;
    NSImage* _thirdImageHover;
    BOOL _isHorver;
    NSTrackingArea* _trackArea;

}
@property(retain)NSImage* firstImage;
@property(retain)NSImage* secondeImage;
@property(retain)NSImage* thirdImage;
@property(retain)NSImage* firstImagePress;
@property(retain)NSImage* secondeImagePress;
@property(retain)NSImage* thirdImagePress;
@property(retain)NSImage* firstImageHover;
@property(retain)NSImage* secondeImageHover;
@property(retain)NSImage* thirdImageHover;



@end
