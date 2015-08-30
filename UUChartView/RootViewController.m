//
//  RootViewController.m
//  UUChartView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "RootViewController.h"
#import "TableViewCell.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation RootViewController
int Switchligt[3]={0};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section?2:4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil] firstObject];
    }
    [cell configUI:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 30);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    label.text = section ? @"Bar":@"Line";
    label.textColor = [UIColor colorWithRed:0.257 green:0.650 blue:0.478 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)SwitchLight{
     NSString *jsondata;  //添加block属性使其可以在block中被改变值
    /** 获取系统时间*/
    NSString* date;
    NSString *time;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    [formatter setDateFormat:@"HH:mm:ss"];
    time=[formatter stringFromDate:[NSDate date]];
    
    
    NSString *basepath= @"http://api.heclouds.com/devices/145588/datapoints";
    NSMutableString *urlpath = [[NSMutableString alloc] initWithString:basepath];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlpath]];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"0jhQbhdFSdbv5GZxcHw6Hb2gaTUA" forHTTPHeaderField:@"api-key"];
    NSString *jsonstring = [NSString stringWithFormat:@"{\"datastreams\":[{\"id\":\"control\",\"datapoints\":[{\"at\":\"%@T%@\",\"value\":%d}]}]}" ,date,time,Switchligt[1]];
    
     [request setHTTPBody:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"urlpath = %@",jsonstring);
    
    
    NSURLResponse *response;
    NSData *returnData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    jsondata=[[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];

}


- (IBAction)redLight:(id)sender {
    if ([sender isOn]) {
        Switchligt[0]=1;
    }
    else{
        Switchligt[0]=0;
    }
    [self SwitchLight];
}

- (IBAction)greenLight:(id)sender {
    if ([sender isOn]) {
        Switchligt[1]=1;
    }
    else{
        Switchligt[1]=0;
    }
   [self SwitchLight];
}

- (IBAction)blueLight:(id)sender {
    if ([sender isOn]) {
        Switchligt[2]=1;
    }
    else{
        Switchligt[2]=0;
    }
    [self SwitchLight];
}
- (IBAction)Refresh:(id)sender {
    
}

@end
