//
//  NSError+Extension.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import "NSError+Extension.h"

@implementation NSError (Extension)

+(id) errorWithDomainEx:(NSString*)domain code:(NSInteger)code msg:(NSString*)msg
{
    NSDictionary* errorMsg = nil;
    if(msg)
    {
        errorMsg = [NSDictionary dictionaryWithObject:msg forKey: NSLocalizedDescriptionKey];
    }
    return [NSError errorWithDomain:domain code:code userInfo:errorMsg];
}


@end
