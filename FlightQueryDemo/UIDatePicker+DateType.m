//
//  UIDatePicker+DateType.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "UIDatePicker+DateType.h"
#import <objc/runtime.h>

@implementation UIDatePicker (DateType)

static void *dateTypeKey = &dateTypeKey;

- (void)setDateType:(DateType)dateType
{
    objc_setAssociatedObject(self, &dateTypeKey, @(dateType), OBJC_ASSOCIATION_ASSIGN);
}

- (DateType)dateType
{
    return [objc_getAssociatedObject(self, &dateTypeKey) intValue];
}

@end