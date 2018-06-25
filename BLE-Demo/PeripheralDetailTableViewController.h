//
//  PeripheralDetailTableViewController.h
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeripheralModel.h"

@interface PeripheralDetailTableViewController : UITableViewController
- (instancetype)initWithPeripheralModel:(PeripheralModel *)model;
@end
