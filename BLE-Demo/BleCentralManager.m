//
//  BleCentralManager.m
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import "BleCentralManager.h"

static BleCentralManager *bleManager = nil;

@interface BleCentralManager() <CBCentralManagerDelegate>
@property (nonatomic, strong) CBCentralManager *centralManager;

@property (nonatomic, copy) ScanPeripheralsServicesBlock scanPeripheralBlock;
@property (nonatomic, copy) ConnectPeripheralBlock connectPeripheralBlock;
@property (nonatomic, copy) CancelPeripheralConnectionBlock cancelConnectBlock ;
@end

@implementation BleCentralManager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bleManager = [[BleCentralManager alloc] init];
    });
    return bleManager;
}

- (instancetype)init {
    self = [super init];
    dispatch_queue_t centralQueue = dispatch_queue_create("centralQueue",DISPATCH_QUEUE_SERIAL);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],CBCentralManagerOptionShowPowerAlertKey,nil];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue options:dic];
    return self;
}

- (void)scanForPeripheralsWithServicesBlock:(ScanPeripheralsServicesBlock)block {
    if (self.centralManager.state == CBCentralManagerStatePoweredOn) {
       [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@NO}];
    }
    self.scanPeripheralBlock = block;
}
- (void)connectPeripheral:(CBPeripheral *)peripheral block:(ConnectPeripheralBlock)block {
    [self.centralManager connectPeripheral:peripheral options:nil];
    self.connectPeripheralBlock = block;
}
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral block:(CancelPeripheralConnectionBlock)block {
    [self.centralManager cancelPeripheralConnection:peripheral];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            break;
        case CBCentralManagerStateResetting:
            break;
        case CBCentralManagerStateUnsupported:
            break;
        case CBCentralManagerStateUnauthorized:
            break;
        case CBCentralManagerStatePoweredOff:
            break;
        case CBCentralManagerStatePoweredOn:
            [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@NO}];
            break;
        default:
            break;
    }
}

#pragma mark  ************CBCentralManagerDelegate**************
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (self.scanPeripheralBlock) {
        PeripheralModel *model = [[PeripheralModel alloc] initWithPeripheral:peripheral adData:advertisementData rssi:RSSI];
        self.scanPeripheralBlock(model);
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    !self.connectPeripheralBlock ? : self.connectPeripheralBlock(YES,nil);
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    !self.connectPeripheralBlock ? : self.connectPeripheralBlock(NO,error);
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    if (error) {
        !self.cancelConnectBlock ? : self.cancelConnectBlock(NO,error);
    } else {
        !self.cancelConnectBlock ? : self.cancelConnectBlock(YES,nil);
    }
}
@end
