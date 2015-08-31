//
//  RootViewController.h
//  UUChartView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZPicker.h"

@interface RootViewController : UIViewController<CZPickerViewDataSource,CZPickerViewDelegate>{
    
}

- (IBAction)Refresh:(id)sender;
- (IBAction)sendData:(id)sender;

- (IBAction)Refresh:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *RedLight;
@property (weak, nonatomic) IBOutlet UISwitch *GreenLigth;
@property (weak, nonatomic) IBOutlet UISwitch *BlueLight;

- (IBAction)redLight:(id)sender;
//- (IBAction)greenLight:(id)sender;
- (IBAction)blueLight:(id)sender;
@end
