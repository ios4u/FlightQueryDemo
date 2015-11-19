//
//  ResultData.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/19.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "ResultData.h"

@implementation ResultData

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if (self)
    {
        NSString *str = [NSString stringWithUTF8String:[data bytes]];
    }
    
    return self;
}

@end
