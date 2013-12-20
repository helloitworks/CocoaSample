//
//  NSString+Extension.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

-(BOOL)pathConformsToUTI:(CFStringRef)UTI;

+ (NSString *)fileSizeDesWithUnsignedLongLong:(unsigned long long)fileSize;


@end
