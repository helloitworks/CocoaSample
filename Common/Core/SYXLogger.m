//
//  Logger.m
//  Thunder
//
//  Created by Shen Yixin on 11-1-24.
//

#import "SYXLogger.h"
#import "NSDate+Extension.h"

NSStringEncoding SYXLoggerDefaultEncoding = NSUTF8StringEncoding;

static SYXLogger *sharedInstance = nil;


@interface SYXLogger()
	-(NSString*)nameOfLevel:(int)logLevel;
@end


@implementation SYXLogger

+(SYXLogger *)sharedInstance{
	if( sharedInstance == nil ){
		sharedInstance = [[self alloc] init];
	}
	return sharedInstance;
}

-(id)init{
	self = [super init];
	if(self){
#ifdef DEBUG
		char *filename = "/tmp/SYXLogger.log";
#else
		char filename[512] = {0};
		NSString *date = [NSDate currentDateString];
		sprintf(filename,"/tmp/SYXLogger_%s.log", [date UTF8String]);
#endif
	    logFile = fopen(filename,"a+");
	}
	return self;
}

-(void) setFilePathName:(NSString *)filePathName
{

#ifdef DEBUG
#else
    NSString *date = [NSDate currentDateString];
    filePathName = [filePathName stringByReplacingOccurrencesOfString:@".log" withString:[NSString stringWithFormat:@"_%@.log",date]];
#endif
    logFile = fopen([filePathName UTF8String],"a+");

}

- (void)log:(int)logLevel func:(const char*)function line:(int)lineNo format:(NSString *)messageFormat,...
{
    if([NSUserName() isEqualToString:@"wangachilles"])
    {
        // 这个控制台污染压力山大啊，菜鸟表示看得很辛苦，屏蔽掉先.........
        return;
    }
    
	va_list args;
	va_start(args,messageFormat);
	
	NSString *now = [NSDate currentDateTimeString];
	NSString *msg = [[[NSString alloc] initWithFormat:messageFormat arguments:args] autorelease];
	NSString *s = [[[NSString alloc] initWithFormat: LOG_FORMAT,now,[self nameOfLevel:logLevel],function,lineNo,msg] autorelease];
    
    if (logLevel == LOGLEVEL_ERROR) {   
        NSLog(@"**************** ERROR ****************%@",[[[NSString alloc] initWithFormat:@"%s-LINE:%d-%@", function, lineNo, msg] autorelease]);
    }
    else {
        NSLog(@"%@",[[[NSString alloc] initWithFormat:@"%s-LINE:%d-%@", function, lineNo, msg] autorelease]);
    }
	if(logFile != NULL){
		const char * logMsg = [s cStringUsingEncoding:SYXLoggerDefaultEncoding];
		fwrite(logMsg, 1,strlen(logMsg), logFile);
		fflush(logFile);
	}
}

-(NSString*)nameOfLevel:(int)logLevel
{
	NSString *levelName = @"UNKNOWN";
	switch (logLevel) {
		case LOGLEVEL_DEBUG:
			levelName = @"DEBUG";
			break;
		case LOGLEVEL_INFO:
			levelName = @"INFO";
			break;
		case LOGLEVEL_WARN:
			levelName = @"WARN";
			break;
		case LOGLEVEL_ERROR:
			levelName = @"ERROR";
			break;
		default:
			break;
	}
	return levelName;
}


@end
