//
//  PeripheralModel.h
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBPeripheral.h>

@interface PeripheralModel : NSObject
@property (nonatomic, strong, readonly) CBPeripheral *peripheral;
@property (nonatomic, copy, readonly) NSDictionary<NSString *, id> *advertisementData;
@property (nonatomic, strong, readonly) NSNumber *RSSI;

- (PeripheralModel *)initWithPeripheral:(CBPeripheral *)peripheral adData:(NSDictionary<NSString *, id> *)advertisementData rssi:(NSNumber *)RSSI;
- (BOOL)isSpecifiedPeripheralModel:(CBPeripheral *)peri;
@end
