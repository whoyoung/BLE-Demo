//
//  BleCentralManager.h
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PeripheralModel.h"

typedef void (^ScanPeripheralsServicesBlock)(PeripheralModel *periModel);
typedef void (^ConnectPeripheralBlock)(BOOL isSuccess, NSError *error);
typedef void (^CancelPeripheralConnectionBlock)(BOOL isSuccess, NSError *error);

@interface BleCentralManager : NSObject

+ (instancetype)sharedManager;

- (void)scanForPeripheralsWithServicesBlock:(ScanPeripheralsServicesBlock)block;
- (void)connectPeripheral:(CBPeripheral *)peripheral block:(ConnectPeripheralBlock)block;
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral block:(CancelPeripheralConnectionBlock)block;

@end
