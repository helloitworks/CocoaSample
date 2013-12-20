//
//  NSFileManager+Extension.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Extension)



/**
 *  create directory safely - check file is exist(exist = success)
 *
 *  @param force If file exist at path but not a directory, it will auto remove if force = YES
 *
 *  @return if directory exist or create success, return YES
 */
- (BOOL) createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error force:(BOOL)force;


/**
 Deep Search a file (a iterator)
 @param directory   the directory to search
 @param hitBlock    the block to return if the path is wanted
 @param maxLevel    search deep
 @return            return the wanted paths, nil if failed, empty if not found
 */
-(NSArray*)deepSearchDirectory:(NSString*)directory
                      hitBlock:(BOOL(^)(NSString* path))hitBlock
                         level:(NSInteger)maxLevel
                         error:(NSError**)error;



/**
 Estimate is symbolic link at path
 */
-(BOOL)isSymbolicLinkWithPath:(NSString*)path error:(NSError**)error;

/**
 Check whether item has been modify since date.
 @param sinceDate       the date to compare
 @param item            file item's path
 */
-(BOOL)isModifySinceDate:(NSDate*)sinceDate item:(NSString*)item error:(NSError**)error;

@end
