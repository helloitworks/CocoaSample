//
//  NSDate+Extension.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "NSDate+Extension.h"

NSString *const NSDateExtensionDefaultDateTimeFormat = @"yyyy-MM-dd  HH:mm:ss";
NSString *const NSDateExtensionDefaultDateFormat = @"yyyy-MM-dd";


@implementation NSDate (Extension)

+(NSString*)currentDateTimeString
{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:NSDateExtensionDefaultDateTimeFormat];
	return [formatter stringFromDate:[NSDate date]];
}

+(NSString*)currentDateString
{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:NSDateExtensionDefaultDateFormat];
	return [formatter stringFromDate:[NSDate date]];
}


@end
