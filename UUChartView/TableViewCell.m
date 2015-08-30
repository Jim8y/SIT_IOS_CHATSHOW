//
//  TableViewCell.m
//  UUChartView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "TableViewCell.h"
#import "UUChart.h"
#include "JSONKit.h"
//#import "ASIHTTPRequest.h"


@interface TableViewCell ()<UUChartDataSource>
{
    
   
    NSArray *datapoints;
    
    NSIndexPath *path;
    UUChart *chartView;
    
    NSMutableArray * TimeToShow;
    NSMutableArray * ValueToShow;
   // AFHTTPRequestOperation *operation;
}
@end

@implementation TableViewCell



- (void)configUI:(NSIndexPath *)indexPath
{
    [self WebDate];
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:indexPath.section==1?UUChartBarStyle:UUChartLineStyle];
    [chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
    
    NSMutableArray *xTitles = [NSMutableArray array];
    if (num>6) {
        for (int i=0; i<num; i++) {
            NSString * str = [TimeToShow objectAtIndex:i];
            [xTitles addObject:str];
        }
    }
   // NSLog(@"#########%d",TimeToShow.);
   /* else{
        for (int i=0; i<num; i++) {
            NSString * str = [TimeToShow objectAtIndex:i];
            [xTitles addObject:str];
        }

    }*/
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{

    if (path.section==0) {
        switch (path.row) {
            case 0:
                return [self getXTitles:20];
            case 1:
                return [self getXTitles:11];
            case 2:
                return [self getXTitles:7];
            case 3:
                return [self getXTitles:7];
            default:
                break;
        }
    }else{
        switch (path.row) {
            case 0:
                return [self getXTitles:11];
            case 1:
                return [self getXTitles:7];
            default:
                break;
        }
    }
    return [self getXTitles:20];
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    
   
    NSArray *ary = [ValueToShow copy];//@[@"22",@"44",@"15",@"40",@"42"];
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
    NSArray *ary3 = @[@"3",@"12",@"25",@"55",@"52"];
    NSArray *ary4 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"];
    
    if (path.section==0) {
        switch (path.row) {
            case 0:
                return @[ary];
            case 1:
                return @[ary4];
            case 2:
                return @[ary1,ary2];
            default:
                return @[ary1,ary2,ary3];
        }
    }else{
        if (path.row) {
            return @[ary1,ary2];
        }else{
            return @[ary4];
        }
    }
}




-(void )WebDate{
    
    
    ////////
    __block NSString *jsondata;  //添加block属性使其可以在block中被改变值
    
    TimeToShow = [NSMutableArray array];
    ValueToShow = [NSMutableArray array];
    
    NSString *basepath= @"http://api.heclouds.com/devices/145588/datapoints?datastream_id=";
    NSMutableString *urlpath = [[NSMutableString alloc] initWithString:basepath];
    [urlpath appendString:@"TestData"];
    [urlpath appendString:@"&limit=20"];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlpath]];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"0jhQbhdFSdbv5GZxcHw6Hb2gaTUA" forHTTPHeaderField:@"api-key"];
   // NSString *jsonstring=@"{\"datastreams\":[{\"id\":\"TestData\",\"datapoints\":[{\"at\":\"2015-08-29T22:00:00\",\"value\":111}]}]}";
   // [request setHTTPBody:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"urlpath = %@",urlpath);
    
   
    
   // dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_async(queue, ^{
    
        //[self WebDate];
     NSURLResponse *response;
    
        NSData *returnData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        jsondata=[[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];

    /*{"errno":0,
       "data":
        {"count":10,
        "datastreams": 
     [{       "datapoints":
     
        [
           {"at":"2015-08-29 22:00:00.000","value":111},
           {"at":"2015-08-29 22:00:00.000","value":111},
           {"at":"2015-08-29 16:54:48.000","value":31},
           {"at":"2015-08-29 16:54:43.000","value":31},
           {"at":"2015-08-29 16:54:43.000","value":2},
           {"at":"2015-08-29 16:54:38.000","value":31},
           {"at":"2015-08-29 16:54:32.000","value":31},
           {"at":"2015-08-29 16:54:27.000","value":31},
           {"at":"2015-08-29 16:54:22.000","value":31},
           {"at":"2015-08-29 16:54:17.000","value":31}
        ],
     
     
           "id":"TestData"}
     ]},
     
     "error":"succ"}*/
       // });
    NSLog(@"---------%@",jsondata);
    NSDictionary *jsonresult=[jsondata objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    NSDictionary *jsonresults_data=[jsonresult objectForKey:@"data"];
    NSArray *jsonresult_datastreams = [jsonresults_data objectForKey:@"datastreams"];
    //NSString * json_array=[jsonresult_datapoints objectAtIndex:0];
    for (int i=0; i<jsonresult_datastreams.count; i++) {
        NSDictionary *item=[jsonresult_datastreams objectAtIndex:i];
        datapoints=[item objectForKey:@"datapoints"];//datapoint作为全局变量。
        //NSLog(@"9999999999%@",datapoints);
        for (int j=0; j<datapoints.count; j++) {
            NSDictionary *item1=[datapoints objectAtIndex:(datapoints.count-j-1)];
            NSString *at =[item1 objectForKey:@"at"];
            NSString *value=[item1 objectForKey:@"value"];
            //long val=[value integerValue];
            NSLog(@"***************%@::::::%@",at,value);
            [TimeToShow addObject:at];
            [ValueToShow addObject:value];
            NSLog(@"$$$$$$$$$$$$$%lu",(unsigned long)TimeToShow.count);
        }
    }
    
}


#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    if (path.section==0 && (path.row==0|path.row==1)) {
        return CGRangeMake(60, 10);
    }
    if (path.section==1 && path.row==0) {
        return CGRangeMake(60, 10);
    }
    if (path.row==2) {
        return CGRangeMake(100, 0);
    }
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    if (path.row==2) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return path.row==2;
}
@end
