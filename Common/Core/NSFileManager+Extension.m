//
//  NSFileManager+Extension.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "NSFileManager+Extension.h"

@implementation NSFileManager (Extension)

-(NSArray*)deepSearchDirectory:(NSString*)directory
                      hitBlock:(BOOL(^)(NSString* path))hitBlock
                         level:(NSInteger)maxLevel
                         error:(NSError**)error
{
    return [self _deepSearchDirectory:directory hitBlock:hitBlock maxLevel:maxLevel currentLevel:0 error:error];
}


-(NSArray*)_deepSearchDirectory:(NSString*)directory
                       hitBlock:(BOOL(^)(NSString* path))hitBlock
                       maxLevel:(NSInteger)maxLevel
                   currentLevel:(NSInteger)currentLevel
                          error:(NSError**)error
{
    NSMutableArray* results = nil;
    
    // estimate params
    if(currentLevel >= maxLevel || nil == hitBlock || nil == directory)
    {
        return results;
    }
    
    // estimate whether directory,readable,symboliclink,error...
    
    BOOL isDirectory = NO;
    BOOL isDirectoryExist = [self fileExistsAtPath:directory isDirectory:&isDirectory];
    BOOL isSymbolicLink = [self isSymbolicLinkWithPath:directory error:error];
    //![self isReadableFileAtPath:directory]
    if(!isDirectoryExist || !isDirectory || isSymbolicLink)
    {
        return results;
    }
    
    // search
    NSArray* contents = [self contentsOfDirectoryAtPath:directory error:error];
    if(nil != *error)
    {
        return results;
    }
    else
    {
        results = [NSMutableArray array];
        NSString* contentFullPath = nil;
        for(NSString* content in contents)
        {
            contentFullPath = [directory stringByAppendingPathComponent:content];
            // search hit content
            if(hitBlock(contentFullPath))
            {
                [results addObject:contentFullPath];
            }
            // iterator search...
            else
            {
                [self fileExistsAtPath:contentFullPath isDirectory:&isDirectory];
                if(isDirectory
                   &&![[NSWorkspace sharedWorkspace] isFilePackageAtPath:contentFullPath]
                   )
                {
                    NSArray* subResults = [self _deepSearchDirectory:contentFullPath hitBlock:hitBlock maxLevel:maxLevel currentLevel:currentLevel + 1 error:error];
                    
                    if(subResults)
                    {
                        [results addObjectsFromArray:subResults];
                    }
                }
                
            }
        }
    }
    return results;
}

-(BOOL)isSymbolicLinkWithPath:(NSString*)path error:(NSError**)error
{
    return [[self attributesOfItemAtPath:path error:error] objectForKey:NSFileType] == NSFileTypeSymbolicLink;
}

-(BOOL)isModifySinceDate:(NSDate*)sinceDate item:(NSString*)item error:(NSError**)error
{
    BOOL result = NO;
    NSDate* date = [[self attributesOfItemAtPath:item error:error] objectForKey:NSFileModificationDate];
    if(date)
    {
        result = NSOrderedDescending == [date compare:sinceDate];
    }
    return result;
}

@end
