//
//  SYXApplicationBundleInfo+ComplexTableView.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-20.
//
//

#import "SYXApplicationBundleInfo+ComplexTableView.h"
#import <objc/runtime.h>

static const void *isExTendedPtr = &isExTendedPtr;
@implementation SYXApplicationBundleInfo (ComplexTableView)

- (BOOL)isExtensed
{
    return (BOOL)objc_getAssociatedObject(self, isExTendedPtr);
}
- (void)setIsExtensed:(BOOL)isExtensed
{
    objc_setAssociatedObject(self, isExTendedPtr, isExtensed, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)fileSizeDesc
{
    return [NSString fileSizeDesWithUnsignedLongLong:self.fileSize];
}

@end
