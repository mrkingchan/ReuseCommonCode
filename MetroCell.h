//
//  MetroCell.h
//  KKJob
//
//  Created by Jason on 2019/1/30.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MetroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *check;

-(void)setCellWithContent:(NSString *)content selected:(BOOL)selected;


@end

NS_ASSUME_NONNULL_END
