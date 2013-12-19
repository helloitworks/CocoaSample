//
//  Logger.h
//  Thunder
//
//  Created by Shen Yixin on 11-1-24.

enum{
	LOGLEVEL_DEBUG,
	LOGLEVEL_INFO,
	LOGLEVEL_WARN,
	LOGLEVEL_ERROR
}LOGLEVEL;

#define LOG_FORMAT @"[%@][%@]%s - LINE:%d - %@\n" //[2011-07-08 12:00:11][DEBUG]-[Logger log] - LINE:3] - xxx

#ifdef DEBUG
  #define LOG_DEBUG(fmt,...) [[SYXLogger sharedInstance]log:LOGLEVEL_DEBUG func:__PRETTY_FUNCTION__ line:__LINE__ format:fmt,##__VA_ARGS__]
  #define LOG_INFO(fmt,...) [[SYXLogger sharedInstance]log:LOGLEVEL_INFO func:__PRETTY_FUNCTION__ line:__LINE__ format:fmt,##__VA_ARGS__]
  #define LOG_WARN(fmt,...) [[SYXLogger sharedInstance]log:LOGLEVEL_WARN func:__PRETTY_FUNCTION__ line:__LINE__ format:fmt,##__VA_ARGS__]
#else
  #define LOG_DEBUG(fmt,...)
  #define LOG_INFO(fmt,...)
  #define LOG_WARN(fmt,...)
  //#define LOG_ERROR(fmt,...)
#endif

//beta release 版本暂时纪录错误日志，便于定位错误
#define LOG_ERROR(fmt,...) [[SYXLogger sharedInstance]log:LOGLEVEL_ERROR func:__PRETTY_FUNCTION__ line:__LINE__ format:fmt,##__VA_ARGS__]

@interface SYXLogger : NSObject {
	@private
	FILE *logFile;
}
+(SYXLogger *)sharedInstance;
- (void)log:(int)logLevel func:(const char*)function line:(int)lineNo format:(NSString *)messageFormat,...;
-(void) setFilePathName:(NSString *)filePathName;

@end
