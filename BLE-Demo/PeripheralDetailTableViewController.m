//
//  PeripheralDetailTableViewController.m
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import "PeripheralDetailTableViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface PeripheralDetailTableViewController ()
@property (nonatomic, strong) PeripheralModel *model;
@end

@implementation PeripheralDetailTableViewController
- (instancetype)initWithPeripheralModel:(PeripheralModel *)model {
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.peripheral.services.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    CBService *service = self.model.peripheral.services[section-1];
    return service.characteristics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    if (indexPath.section == 0) {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.model.advertisementData];
        cell.detailTextLabel.text = @"";
        return cell;
    }
    CBService *service = self.model.peripheral.services[indexPath.section-1];
    CBCharacteristic *character = service.characteristics[indexPath.row];
    cell.textLabel.text = [[NSString alloc] initWithData:character.value encoding:NSUTF8StringEncoding];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",character.properties];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blueColor];
    if (section == 0) {
        label.text = @"advertisementData";
        return label;
    }
    CBService *service = self.model.peripheral.services[section-1];
    label.text = service.UUID.UUIDString;
    return label;
}

@end
