//
//  UIDatePicker+DateType.h
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, DateType)
{
    // 出发
    DateTypeDepart = 0,
    // 返程
    DateTypeBack,
};

@interface UIDatePicker (DateType)

@property (nonatomic, assign) DateType dateType;

@end
