//
//  ASSystemManager.h
//  ASCommon
//
//  Created by Shen Yixin on 13-12-18.
//
//

// Some important info of app bundle
@interface SYXApplicationBundleInfo : NSObject
{
    NSString* _name;
    NSString* _displayName;
    NSString* _bundleId;
    NSString* _version;
    NSString* _iconPath;
    NSString* _path;
    NSString* _longVersion;
    NSUInteger _fileSize;
}
@property(retain)NSString* name;
@property(retain)NSString* displayName;
@property(retain)NSString* bundleId;
@property(retain)NSString* version;                 // suggest version
@property(retain)NSString* iconPath;
@property(retain)NSString* path;
@property(retain)NSString* longVersion;
@property(assign) NSUInteger fileSize;

@end


@interface SYXSystemManager : NSObject

/*********************** Singleton *****************************/
+(id)systemManager;

/*********************** App Info *****************************/
/**
 @param domain  NSUserDomain or NSSystemDomain
 @return        the suggest path for requst
 @note          If want get more info, call NSSearchPathForDirectoriesInDomains directly
 */
+(NSString*)defaultInternetPluginPath:(NSSearchPathDomainMask)domain;
+(NSString*)defaultApplicationPath:(NSSearchPathDomainMask)domain;
+(NSString*)defaultInputMethodPath:(NSSearchPathDomainMask)domain;

+(NSString*)applicationName;

/**
 Deep Search directory for kUTTypeApplicationBundle file
 @return array of app paths, nil if no app found...
 */
+(NSArray*)appsInDirectory:(NSString*)directory searchLevel:(NSInteger)level;

/**
 Deep Search directory for .bundle .plugin file
 @return array of plugin paths, nil if no app found...
 */
+(NSArray*)internetPluginAtDirectory:(NSString*)directory searchLevel:(NSInteger)level;

/**
 Get info of the app at path..
 @return nil if Error
 @path Application path
 */
+(SYXApplicationBundleInfo*)bundleInfoOfApp:(NSString*)path;


/**
 Get Infos of apps and plugins at directory...
 @return A dict of SYXApplicationBundleInfo, key is identifier of app
 @return nil if no app found
 */
+(NSDictionary*)bundleInfosInDirectory:(NSString*)directory searchLevel:(NSInteger)level;

/**
 Find app at path's process id
 @param path the app to check
 @return -1 if not running
 */
+(pid_t)isAppRunningWithPath:(NSString*)path;

@end