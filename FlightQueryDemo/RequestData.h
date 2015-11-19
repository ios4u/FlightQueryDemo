//
//  RequestData.h
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryVC.h"

@interface RequestData : NSObject

@property (nonatomic, copy) NSString *departCity;
@property (nonatomic, copy) NSString *arrivalCity;
@property (nonatomic, strong) NSDate *departDate;
@property (nonatomic, strong) NSDate *backDate;
@property (nonatomic, assign) FlightQueryDirection direction;

@property (nonatomic, strong) void (^refrushView)();

- (NSString *)requestString;

@end
