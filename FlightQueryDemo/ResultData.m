//
//  ResultData.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/19.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "ResultData.h"
#import "OneWayDirectFlightInfo.h"
#import "TFHpple.h"

@implementation ResultData

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if (self)
    {
        // 先判断数据类型 单程还是往返 直达还是中转
        // 以下只做了单程直达一种类型
        
        // 用TFHpple解析HTML文档
        TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
        
        // 寻找p标签
        NSArray *elementsInfo = [doc searchWithXPathQuery:@"//p"];
        // 筛选p标签
        NSMutableArray *arrayDepartTime = [NSMutableArray array];
        NSMutableArray *arrayArriveTime = [NSMutableArray array];
        NSMutableArray *arrayDepartAirPort = [NSMutableArray array];
        NSMutableArray *arrayArriveAirPort = [NSMutableArray array];
        NSMutableArray *arrayPrice = [NSMutableArray array];
        
        [elementsInfo enumerateObjectsUsingBlock:^(TFHppleElement *element, NSUInteger idx, BOOL *stop){
            
            if ([element content])
            {
                if ([[element raw] containsString:@"from-time time-font"])
                {
                    [arrayDepartTime addObject:[element content]];
                }
                else if ([[element raw] containsString:@"from-place ellipsis"])
                {
                    [arrayDepartAirPort addObject:[element content]];
                }
                else if ([[element raw] containsString:@"to-time time-font"])
                {
                    [arrayArriveTime addObject:[element content]];
                }
                else if ([[element raw] containsString:@"to-place ellipsis"])
                {
                    [arrayArriveAirPort addObject:[element content]];
                }
                else if ([[element raw] containsString:@"<p class=\"price-info\">"])
                {
                    for (TFHppleElement *elementChild in [element children])
                    {
                        if ([[elementChild content] length] > 0)
                        {
                            [arrayPrice addObject:[elementChild content]];
                            break;
                        }
                    }
                }
            }
        }];
        
        // 寻找span标签
        NSArray *elementOtherInfo = [doc searchWithXPathQuery:@"//span"];
        NSMutableArray *arrayFlightNumber = [NSMutableArray array];
        NSMutableArray *arrayPlaneType = [NSMutableArray array];
        

        [elementOtherInfo enumerateObjectsUsingBlock:^(TFHppleElement *element, NSUInteger idx, BOOL *stop){
            
            if ([element content])
            {
                if ([[element raw] containsString:@"company1 ellipsis"])
                {
                    [arrayFlightNumber addObject:[element content]];
                }
                else if ([[element raw] containsString:@"company2 ellipsis"])
                {
                    [arrayPlaneType addObject:[element content]];
                }
            }
        }];
        
        // 寻找div标签
        NSArray *elementDiscountInfo = [doc searchWithXPathQuery:@"//div"];
        NSMutableArray *arrayDiscountInfo = [NSMutableArray array];
        
        [elementDiscountInfo enumerateObjectsUsingBlock:^(TFHppleElement *element, NSUInteger idx, BOOL *stop){
            
            if ([element content])
            {
                if ([[element raw] containsString:@"<div class=\"price"])
                {
                    for (TFHppleElement *elementChild in [element children])
                    {
                        if ([[elementChild raw] hasPrefix:@"<p class=\"more-info\">"])
                        {
                            [arrayDiscountInfo addObject:[elementChild content]];
                            break;
                        }
                    }
                }
            }
        }];
        
        // 验证数据完整性
        self.arrayResult = [NSMutableArray array];
        const NSUInteger count = [arrayDepartTime count];
        
        if ([arrayDepartTime count] == count &&
            [arrayDepartAirPort count] == count &&
            [arrayArriveTime count] == count &&
            [arrayArriveAirPort count] == count &&
            [arrayDiscountInfo count] == count &&
            [arrayFlightNumber count] == count &&
            [arrayPlaneType count] == count &&
            [arrayPrice count] == count)
        {
            for (int i = 0; i<[arrayPrice count]; i++)
            {
                OneWayDirectFlightInfo *temp = [[OneWayDirectFlightInfo alloc] init];
                [temp setDepartTime:[arrayDepartTime objectAtIndex:i]];
                [temp setDepartAirPort:[arrayDepartAirPort objectAtIndex:i]];
                [temp setArriveTime:[arrayArriveTime objectAtIndex:i]];
                [temp setArriveAirPort:[arrayArriveAirPort objectAtIndex:i]];
                [temp setDiscountInfo:[arrayDiscountInfo objectAtIndex:i]];
                [temp setFlightNumber:[arrayFlightNumber objectAtIndex:i]];
                [temp setPlaneType:[arrayPlaneType objectAtIndex:i]];
                [temp setPrice:[arrayPrice objectAtIndex:i]];
                
                [self.arrayResult addObject:temp];
            }
        }
        else
        {
            NSLog(@"数据格式错误");
            return nil;
        }
    }
    
    return self;
}

@end
