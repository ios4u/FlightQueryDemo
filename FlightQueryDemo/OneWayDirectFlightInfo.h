//
//  FlightInfo.h
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/19.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightInfo.h"

// 单程非中转航班信息
@interface OneWayDirectFlightInfo : FlightInfo

// 出发时间
@property (nonatomic, copy) NSString *departTime;
// 到达时间
@property (nonatomic, copy) NSString *arriveTime;
// 出发机场
@property (nonatomic, copy) NSString *departAirPort;
// 到达机场
@property (nonatomic, copy) NSString *arriveAirPort;
// 航班号
@property (nonatomic, copy) NSString *flightNumber;
// 机型
@property (nonatomic, copy) NSString *planeType;
// 价格
@property (nonatomic, copy) NSString *price;
// 折扣信息
@property (nonatomic, copy) NSString *discountInfo;

@end
