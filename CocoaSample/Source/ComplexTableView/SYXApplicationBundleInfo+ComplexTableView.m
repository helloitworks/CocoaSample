//
//  SYXApplicationBundleInfo+ComplexTableView.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import "SYXApplicationBundleInfo+ComplexTableView.h"

@implementation SYXApplicationBundleInfo (ComplexTableView)

- (NSString *)fileSizeDesc
{
    return [NSString fileSizeDesWithUnsignedLongLong:self.fileSize];
}

@end
