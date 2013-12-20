//
//  ASSystemManager.m
//  ASCommon
//
//  Created by Shen Yixin on 13-12-18.
//
//

#import "SYXSystemManager.h"
#include <stdlib.h>

@implementation SYXApplicationBundleInfo
@synthesize name = _name;
@synthesize displayName = _displayName;
@synthesize bundleId = _bundleId;
@synthesize version = _version;
@synthesize iconPath = _iconPath;
@synthesize path = _path;
@synthesize longVersion = _longVersion;
@synthesize fileSize = _fileSize;
-(NSString*)description
{
    return [NSString stringWithFormat:@"\nbundleId:%@\nVersion:%@\nIconPath:%@\nPath:%@\nName:%@",self.bundleId,self.version,self.iconPath,self.path,self.name];
}
-(void)dealloc
{
    self.name = nil;
    self.displayName = nil;
    self.longVersion = nil;
    self.bundleId = nil;
    self.version = nil;
    self.iconPath = nil;
    self.path = nil;
    [super dealloc];
}

@end
@implementation SYXSystemManager

+(id)systemManager
{
    static SYXSystemManager* singleton = nil;
    if(nil == singleton)
    {
        @synchronized(self)
        {
            if(nil == singleton)
            {
                singleton = [self new];
            }
        }
    }
    return singleton;
}
#pragma mark - App Info
+(NSString*)defaultInternetPluginPath:(NSSearchPathDomainMask)domain
{
    NSString* path = nil;
    switch (domain)
    {
        case NSUserDomainMask:
        {
            path = [NSHomeDirectory() stringByAppendingString:@"/Library/Internet Plug-Ins"];
        }
            break;
        case NSSystemDomainMask:
        {
            path = @"/Library/Internet Plug-Ins";
        }
            break;
        default:
            break;
    }
    return path;
}
+(NSString*)defaultApplicationPath:(NSSearchPathDomainMask)domain
{
    NSArray* items = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, domain, YES);
    NSString* path = nil;
    if(items && 0 != [items count])
    {
        path = [items objectAtIndex:0];
    }
    return path;
}

+(NSString*)defaultInputMethodPath:(NSSearchPathDomainMask)domain
{
    NSArray* items = NSSearchPathForDirectoriesInDomains(NSInputMethodsDirectory, domain, YES);
    NSString* path = nil;
    if(items && 0 != [items count])
    {
        path = [items objectAtIndex:0];
    }
    return path;
}

+(NSString*)applicationName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+(NSArray*)appsInDirectory:(NSString*)directory searchLevel:(NSInteger)level;
{
    NSError* error = nil;
    NSFileManager* fileMgr = [[[NSFileManager alloc] init] autorelease];
    return [fileMgr deepSearchDirectory:directory hitBlock:^BOOL(NSString* path)
            {
                return [path pathConformsToUTI:kUTTypeApplicationBundle];
            } level:level error:&error];
}
+(NSArray*)internetPluginAtDirectory:(NSString*)directory searchLevel:(NSInteger)level
{
    NSError* error = nil;
    NSFileManager* fileMgr = [[[NSFileManager alloc] init] autorelease];
    return [fileMgr deepSearchDirectory:directory hitBlock:^BOOL(NSString* path)
            {
                return [[path pathExtension] isEqualToString:@"plugin"] || [[path pathExtension] isEqualToString:@"bundle"];
            } level:level error:&error];
}

+(SYXApplicationBundleInfo*)bundleInfoOfApp:(NSString*)path
{
    SYXApplicationBundleInfo* info = nil;
    NSDictionary* infoDict = [NSDictionary dictionaryWithContentsOfFile:[path stringByAppendingPathComponent:@"Contents/Info.plist"]];
    if(infoDict )
    {
        NSString* identifier = [infoDict objectForKey:@"CFBundleIdentifier"];
        if(nil != identifier && ![identifier isEqualToString:@""])
        {
            info = [[SYXApplicationBundleInfo new] autorelease];
            NSString *shortVer = [infoDict objectForKey:@"CFBundleShortVersionString"];
            info.longVersion = [infoDict objectForKey:@"CFBundleVersion"];
            info.version = [self makeSuggestVersionWithLong:info.longVersion short:shortVer];
            info.name = [infoDict objectForKey:@"CFBundleName"];
            info.displayName =  [[NSFileManager defaultManager] displayNameAtPath:path];
            info.bundleId = [identifier lowercaseString];
            info.iconPath = [infoDict objectForKey:@"CFBundleIconFile"];
            info.path = path;
            
            //TODO: fileSize
            
        }
    }
    return info;
}


/*
 ll ~/Library/Internet\ Plug-Ins
 total 8
 0 drwx------+  6 sam  staff   204B 12  4 16:07 .
 0 drwx------@ 53 sam  staff   1.8K 11 26 21:04 ..
 0 drwxr-xr-x@  4 sam  staff   136B  1 23  2013 WangwangPlugin.plugin
 8 lrwxrwxr-x   1 sam  staff    70B  8 16 17:30 aThunderPlugIn.plugin -> /Applications/Thunder.app/Contents/BrowserPlugins/ThunderPlugIn.plugin
 0 drwxr-xr-x@  4 sam  staff   136B  9 23 10:06 aliedit.plugin
 0 drwxr-xr-x   3 sam  staff   102B  5 30  2013 iSecurityPAB.bundle
 */
+(NSDictionary*)bundleInfosInDirectory:(NSString*)directory searchLevel:(NSInteger)level
{
    NSMutableDictionary* results = nil;
    
    //apps plugin bundle In Directory
    NSError* error = nil;
    NSFileManager* fileMgr = [[[NSFileManager alloc] init] autorelease];
    NSArray* arr = [fileMgr deepSearchDirectory:directory hitBlock:^BOOL(NSString* path)
                    {
                        return [path pathConformsToUTI:kUTTypeApplicationBundle] || [[path pathExtension] isEqualToString:@"plugin"] || [[path pathExtension] isEqualToString:@"bundle"];
                    } level:level error:&error];
    
    if(arr && 0 != [arr count])
    {
        results = [NSMutableDictionary dictionary];
        for(NSString* path in arr)
        {
            SYXApplicationBundleInfo* info = [[self class] bundleInfoOfApp:path];
            if(info)
            {
                SYXApplicationBundleInfo* old = [results objectForKey:info.bundleId];
                if(old && [[old version] isGreaterThan:[info version]])
                {
                    // 只要最新版本......
                    continue;
                }
                [results setObject:info forKey:info.bundleId];
            }
        }
    }
    return results;
}

+(NSString*)makeSuggestVersionWithLong:(NSString*)longV short:(NSString*)shortV
{
    // choose
    NSString* value = @"";
    if(shortV)
    {
        value = shortV;
    }
    else if(!shortV && longV)
    {
        value = longV;
    }
    return value;
}

+(pid_t)isAppRunningWithPath:(NSString*)path
{
    SYXApplicationBundleInfo* info = [self bundleInfoOfApp:path];
    NSArray* runningApps = [[NSWorkspace sharedWorkspace] runningApplications];
    for(NSRunningApplication* runningApp in runningApps)
    {
        if([[runningApp bundleIdentifier] isEqualToString:info.bundleId])
        {
            return[runningApp processIdentifier];
        }
    }
    return -1;
}

@end
