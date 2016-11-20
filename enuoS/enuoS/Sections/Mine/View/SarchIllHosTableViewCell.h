//
//  SarchIllHosTableViewCell.h
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SarchIllHosTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *hosImage;
@property (weak, nonatomic) IBOutlet UILabel *hosName;
@property (weak, nonatomic) IBOutlet UILabel *effectLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;

@end
