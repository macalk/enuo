//
//  AppointChecKModel.h
//  enuo4
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointChecKModel : NSObject
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *pretime;
@property (nonatomic,copy)NSString *prepaid;
@property (nonatomic,copy)NSString *hospital;
@property (nonatomic,copy)NSString *doctor_name;
@property (nonatomic,copy)NSString *check_name;
- (id)initWithDic:(NSDictionary *)dic;
+ (id)appointInitWithDic:(NSDictionary *)dic;

@end