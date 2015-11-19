//
//  FlightInfoCell.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/19.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "OneWayDirectFlightCell.h"
#import "OneWayDirectFlightInfo.h"

@interface OneWayDirectFlightCell ()

@property (nonatomic, weak) IBOutlet UILabel *departTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *departAirPortLabel;
@property (nonatomic, weak) IBOutlet UILabel *arriveTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *arriveAirPortLabel;
@property (nonatomic, weak) IBOutlet UILabel *planeInfoLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *discountLabel;

@end

@implementation OneWayDirectFlightCell

- (void)refrushCell:(FlightInfo *)info;
{
    if ([info isKindOfClass:[OneWayDirectFlightInfo class]])
    {
        OneWayDirectFlightInfo *oneWayDirectFlightInfo = (OneWayDirectFlightInfo *)info;
        [self.departTimeLabel setText:oneWayDirectFlightInfo.departTime];
        [self.departAirPortLabel setText:oneWayDirectFlightInfo.departAirPort];
        [self.arriveTimeLabel setText:oneWayDirectFlightInfo.arriveTime];
        [self.arriveAirPortLabel setText:oneWayDirectFlightInfo.arriveAirPort];
        [self.planeInfoLabel setText:[NSString stringWithFormat:@"%@ %@", oneWayDirectFlightInfo.flightNumber, oneWayDirectFlightInfo.planeType]];
        [self.priceLabel setText:[NSString stringWithFormat:@"￥%@", oneWayDirectFlightInfo.price]];
        [self.discountLabel setText:oneWayDirectFlightInfo.discountInfo];
    }
}

@end
