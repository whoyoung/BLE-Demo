//
//  ViewController.m
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import "ViewController.h"
#import "BleCentralManager.h"
#import "PeripheralModel.h"
#import "PeripheralDetailTableViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *periModels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [[BleCentralManager sharedManager] scanForPeripheralsWithServicesBlock:^(PeripheralModel *periModel) {
        if (!periModel.peripheral.name) return;
        [self.periModels addObject:periModel];
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
    }];
    
}
- (void)reloadTableView {
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.periModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    PeripheralModel *model = indexPath.row > self.periModels.count - 1 ? self.periModels[self.periModels.count - 1] : self.periModels[indexPath.row];
    cell.textLabel.text = model.peripheral.name;
    cell.detailTextLabel.text = model.RSSI.stringValue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PeripheralModel *model = self.periModels[indexPath.row];
    
    PeripheralDetailTableViewController *peripheralDetailVC = [[PeripheralDetailTableViewController alloc] initWithPeripheralModel:model];
    [self.navigationController pushViewController:peripheralDetailVC animated:YES];
    
//    [[BleCentralManager sharedManager] connectPeripheral:model.peripheral block:^(BOOL isSuccess, NSError *error) {
//        if (isSuccess) {
//            NSLog(@"connect success");
//        } else {
//            NSLog(@"connect error = %@",error);
//        }
//    }];
    
}

- (NSMutableArray *)periModels {
    if (!_periModels) {
        _periModels = [NSMutableArray arrayWithCapacity:0];
    }
    return _periModels;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
