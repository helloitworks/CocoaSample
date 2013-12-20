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


+ (NSString *)fileSizeDesWithUnsignedLongLong:(unsigned long long)fileSize
{
    if(fileSize <= 0) {
		return @"0B";
	}
    else if(fileSize < 1000) {
        return [NSString stringWithFormat:@"%lldB", fileSize];
    }
    else if(fileSize < 1000*1000) {
        return [NSString stringWithFormat:@"%lldK", (fileSize/1000)];
    }
    else if(fileSize < 1000*1000*1000) {
        return [NSString stringWithFormat:@"%.1fM", ((double)fileSize/(1000.0*1000.0))];
    }
    else if(fileSize < (UInt64)1000* (UInt64)1000* (UInt64)1000* (UInt64)1000)
    {
        return [NSString stringWithFormat:@"%.2fG", ((double)fileSize/(1000.0*1000.0*1000.0))];
    }
    else {
        return @"0B";
    }
}



@end
