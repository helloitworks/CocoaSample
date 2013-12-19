//
//  NSString+Extension.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(BOOL)pathConformsToUTI:(CFStringRef)UTI
{
    BOOL value = false;
    CFStringRef fileExtension = (CFStringRef) [self pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
    value = UTTypeConformsTo(fileUTI, UTI);
    CFRelease(fileUTI);
    return value;
}


@end
