//
//  BleCentralManager.m
//  BLE-Demo
//
//  Created by 杨虎 on 2018/6/15.
//  Copyright © 2018年 whoyoung. All rights reserved.
//

#import "BleCentralManager.h"

static BleCentralManager *bleManager = nil;

@implementation BleCentralManager
+ (instancetype)sharedManager {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!bleManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            bleManager = [super allocWithZone:zone];
        });
    }
    return bleManager;
}
- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bleManager = [super init];
    });
    return bleManager;
}
@end
