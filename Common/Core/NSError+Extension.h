//
//  NSError+Extension.h
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import <Foundation/Foundation.h>

@interface NSError (Extension)

+(id) errorWithDomainEx:(NSString*)domain code:(NSInteger)code msg:(NSString*)msg;

@end
