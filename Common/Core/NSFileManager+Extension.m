//
//  NSFileManager+Extension.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "NSFileManager+Extension.h"

NSString *const NSFileManagerExtensionError = @"NSFileManagerExtensionError";

@implementation NSFileManager (Extension)

- (BOOL) createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error force:(BOOL)force
{
    BOOL isDirectory = YES;
    BOOL isExist = [self fileExistsAtPath:path isDirectory:&isDirectory];
    
    BOOL result = YES;
    if (isExist)
    {
        if (!isDirectory)
        {
            if (force)
            {
                BOOL result = [self removeItemAtPath:path error:error];
                if (result)
                {
                    result = [self createDirectoryAtPath:path withIntermediateDirectories:createIntermediates attributes:attributes error:error];
                }
            }
            else
            {
                result = NO;
                *error = [[NSError errorWithDomainEx:NSFileManagerExtensionError code:-1 msg:@"path exist, but it is a file and not directory!"]retain];
            }
        }
    }
    else
    {
        result = [self createDirectoryAtPath:path withIntermediateDirectories:createIntermediates attributes:attributes error:error];
    }
    
    if (!result)
    {
        LOG_ERROR(@"fail to create path:%@ error = %@", path,*error);
    }
    return result;
}


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
        //TODO:test
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
