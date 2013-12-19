//
//  SYXApplicationBundleInfo+View.m
//  CocoaSample
//
//  Created by Shen Yixin on 13-12-19.
//
//

#import "SYXApplicationBundleInfo+View.h"
#import <objc/runtime.h>

@implementation SYXApplicationBundleInfo (View)
static const void *isCheckedPtr = &isCheckedPtr;

@dynamic isChecked;
- (BOOL)isChecked
{
    return (BOOL)objc_getAssociatedObject(self, isCheckedPtr);
}
- (void)setIsChecked:(BOOL)isChecked
{
    objc_setAssociatedObject(self, isCheckedPtr, isChecked, OBJC_ASSOCIATION_ASSIGN);
}

@end
