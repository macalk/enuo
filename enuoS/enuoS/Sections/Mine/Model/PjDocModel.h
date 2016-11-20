//
//  PjDocModel.h
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PjDocModel : NSObject

@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *doc_id;
@property (nonatomic,copy)NSString *doctor;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *zhui;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,copy)NSString *dep_name;
@property (nonatomic,copy)NSString *professional;
@property (nonatomic,copy)NSString *doctor_photo;




- (id)initWithDic:(NSDictionary *)dic;

+ (id)pjDocModelWithDic:(NSDictionary *)dic;

@end
