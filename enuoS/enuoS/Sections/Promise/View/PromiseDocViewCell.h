//
//  PromiseDocViewCell.h
//  enuoNew
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromiseDocViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nuoImage;
@property (weak, nonatomic) IBOutlet UILabel *nuoNumber;
@property (weak, nonatomic) IBOutlet UILabel *proLabel;
@property (weak, nonatomic) IBOutlet UILabel *deskLabel;
@property (weak, nonatomic) IBOutlet UILabel *hosLabel;
@property (weak, nonatomic) IBOutlet UILabel *pepLaebl;
@property (weak, nonatomic) IBOutlet UILabel *illLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
