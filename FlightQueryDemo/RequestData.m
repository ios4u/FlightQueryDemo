//
//  RequestData.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "RequestData.h"
#import "NSDate+Formate.h"
#import <objc/runtime.h>

static NSString *requestURL = @"http://touch.qunar.com/h5/flight/flightlist?";

@implementation RequestData

- (id)init
{
    self = [super init];
    if (self)
    {
        _departCity = @"北京";
        _arrivalCity = @"上海";
        _departDate = [NSDate date];
        _backDate = [NSDate date];
        _direction = FlightQueryDirectionOneWay;
    }
    return self;
}

#pragma mark setter

- (void)setDepartCity:(NSString *)departCity
{
    if (![_departCity isEqualToString:departCity])
    {
        _departCity = [departCity copy];
    }
    
    self.refrushView();
}

- (void)setArrivalCity:(NSString *)arrivalCity
{
    if (![_arrivalCity isEqualToString:arrivalCity])
    {
        _arrivalCity = [arrivalCity copy];
    }
    
    self.refrushView();
}

- (void)setDepartDate:(NSDate *)departDate
{
    _departDate = departDate;
    self.refrushView();
}

- (void)setBackDate:(NSDate *)backDate
{
    _backDate = backDate;
    self.refrushView();
}

- (void)setDirection:(FlightQueryDirection)direction
{
    _direction = direction;
    self.refrushView();
}

#pragma mark 

- (NSString *)requestString
{
    NSMutableString *strUrl = [NSMutableString stringWithString:requestURL];
    
    if ([self departCity])
    {
        [strUrl appendFormat:@"startCity=%@", [self departCity]];
    }
    else
    {
        return @"";
    }
    
    if ([self arrivalCity])
    {
        [strUrl appendFormat:@"&destCity=%@", [self arrivalCity]];
    }
    else
    {
        return @"";
    }
    
    if ([[self departDate] formateString])
    {
        [strUrl appendFormat:@"&startDate=%@", [[self departDate] formateString]];
    }
    else
    {
        return @"";
    }
    
    if ([self direction] == FlightQueryDirectionOneWay)
    {
        [strUrl appendString:@"&backDate=&flightType=oneWay"];
    }
    else if ([self direction] == FlightQueryDirectionRoundWay)
    {
        if ([[self backDate] formateString])
        {
            [strUrl appendFormat:@"&backDate=%@", [[self backDate] formateString]];
            [strUrl appendString:@"&flightType=roundWay"];
        }
        else
        {
            return @"";
        }
    }
    
    return [strUrl copy];
}


@end
