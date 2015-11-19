//
//  QueryVC.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "QueryVC.h"
#import "NSDate+Formate.h"
#import "RequestData.h"
#import "ResultData.h"
#import "UIDatePicker+DateType.h"


@interface QueryVC ()

// View
@property (nonatomic, weak) IBOutlet UISegmentedControl *directionSegmentControl;
@property (nonatomic, weak) IBOutlet UITextField *departCityTextField;
@property (nonatomic, weak) IBOutlet UITextField *arriveCityTextField;
@property (nonatomic, weak) IBOutlet UIButton *departDateButton;
@property (nonatomic, weak) IBOutlet UIButton *backDateButton;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

// Data
@property (nonatomic, strong) RequestData *requestData;

@end

@implementation QueryVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 默认单程
    [self.directionSegmentControl setSelectedSegmentIndex:FlightQueryDirectionOneWay];
    // 最小日期是当天
    [self.datePicker setMinimumDate:[NSDate date]];
    //
    self.requestData = [[RequestData alloc] init];
    
    // 刷新界面
    __weak QueryVC *weakSelf = self;
    [self.requestData setRefrushView:^{
        
        // 切换单程往返
        if (weakSelf.requestData.direction == FlightQueryDirectionOneWay)
        {
            [weakSelf.backDateButton setHidden:YES];
        }
        else if (weakSelf.requestData.direction == FlightQueryDirectionRoundWay)
        {
            [weakSelf.backDateButton setHidden:NO];
        }
        
        // 输入框
        [weakSelf.departCityTextField setText:[weakSelf.requestData departCity]];
        [weakSelf.arriveCityTextField setText:[weakSelf.requestData arrivalCity]];
        
        // 日期选择
        [weakSelf.departDateButton setTitle:[NSString stringWithFormat:@"出发日期 %@", [[weakSelf.requestData departDate] formateString]] forState:UIControlStateNormal];
        [weakSelf.backDateButton setTitle:[NSString stringWithFormat:@"返程日期 %@", [[weakSelf.requestData backDate] formateString]] forState:UIControlStateNormal];
    }];
    self.requestData.refrushView();
}

// 点击日期选择按钮
- (IBAction)selectDate:(id)sender
{
    if (sender == self.departDateButton)
    {
        // 标记为出发日期
        [self.datePicker setDateType:DateTypeDepart];
    }
    else if (sender == self.backDateButton)
    {
        // 标记为返程日期
        [self.datePicker setDateType:DateTypeBack];
    }
    else
    {
        return;
    }
    
    // 显示选择器
    if (self.datePicker.hidden)
    {
        [self.datePicker setDate:[NSDate date]];
        [self.datePicker setHidden:NO];
    }
}

// 切换单程往返
- (IBAction)directionSegmentValueChanged:(id)sender
{
    if (sender == self.directionSegmentControl)
    {
        [self.requestData setDirection:[self.directionSegmentControl selectedSegmentIndex]];
    }
}

// 隐藏键盘和日期选择器
- (IBAction)hiddenKeyBoard:(id)sender
{
    [self.datePicker setHidden:YES];
    [self.view endEditing:YES];
}

// 日期选择器事件
- (IBAction)datePickerChanged:(id)sender
{
    if (sender == self.datePicker)
    {
        if ([self.datePicker dateType] == DateTypeDepart)
        {
            [self.requestData setDepartDate:[self.datePicker date]];
        }
        else if ([self.datePicker dateType] == DateTypeBack)
        {
            [self.requestData setBackDate:[self.datePicker date]];
        }
    }
}

// 搜索
- (IBAction)search:(id)sender
{
    NSURL *url = [[NSURL alloc] initWithString:[[self.requestData requestString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          
                                          // 状态码200
                                          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                          NSInteger responseStatusCode = [httpResponse statusCode];
                                          
                                          if (responseStatusCode == 200)
                                          {
                                              ResultData *result = [[ResultData alloc] initWithData:data];
                                          }
                                          else
                                          {
                                              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[[error userInfo] objectForKey:NSLocalizedFailureReasonErrorKey] message:[NSString stringWithFormat:@"状态码: %ld", (long)responseStatusCode] preferredStyle:UIAlertControllerStyleAlert];
                                              UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                                              [alertController addAction:action];
                                           
                                              [self presentViewController:alertController animated:YES completion:nil];
                                          }
//
//                                          // 在webView中加载数据
//                                          [self.webView loadData:data
//                                                        MIMEType:@"text/html"
//                                                textEncodingName:@"utf-8"
//                                                         baseURL:nil];
//                                          
//                                          // 加载数据完毕，停止spinner
//                                          [self.spinner stopAnimating];
                                      }];
    // 使用resume方法启动任务
    [dataTask resume];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenKeyBoard:nil];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
