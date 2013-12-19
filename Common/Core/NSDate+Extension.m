//
//  NSDate+Extension.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "NSDate+Extension.h"

NSString *const NSDateExtensionDefaultDateTimeFormat = @"MM月dd日  HH:mm";
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
