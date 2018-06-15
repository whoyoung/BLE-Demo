//
//  PeripheralModel.m
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import "PeripheralModel.h"

@implementation PeripheralModel
- (PeripheralModel *)initWithPeripheral:(CBPeripheral *)peripheral adData:(NSDictionary<NSString *, id> *)advertisementData rssi:(NSNumber *)RSSI {
    self = [super init];
    if (self) {
        _peripheral = peripheral;
        _advertisementData = advertisementData;
        _RSSI = RSSI;
    }
    return self;
}

- (BOOL)isSpecifiedPeripheralModel:(CBPeripheral *)peri {
    if ([self.peripheral.identifier.UUIDString isEqualToString:peri.identifier.UUIDString]) return YES;
    return NO;
}
@end
