//
//  NSDate+Extension.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  return current date time string, format:2014-01-01 01:01:01
 *
 *  @return current date time string, format:2014-01-01 01:01:01
 */
+(NSString*)currentDateTimeString;

/**
 *  return current date string, format:2014-01-01
 *
 *  @return current date string, format:2014-01-01
 */
+(NSString*)currentDateString;
@end
