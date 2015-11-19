//
//  RequestData.h
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryVC.h"

// 请求数据
@interface RequestData : NSObject

// 出发城市
@property (nonatomic, copy) NSString *departCity;
// 到达城市
@property (nonatomic, copy) NSString *arrivalCity;
// 出发日期
@property (nonatomic, strong) NSDate *departDate;
// 到达日期
@property (nonatomic, strong) NSDate *backDate;
// 单程返程
@property (nonatomic, assign) FlightQueryDirection direction;

// 刷新请求页面的Block
@property (nonatomic, strong) void (^refrushView)();

// 拼凑请求参数
- (NSString *)requestString;

@end
