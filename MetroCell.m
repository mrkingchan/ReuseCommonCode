//
//  MetroCell.m
//  KKJob
//
//  Created by Jason on 2019/1/30.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "MetroCell.h"

@implementation MetroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithContent:(NSString *)content selected:(BOOL)selected {
    _content.text = content;
    self.backgroundColor = selected ? [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]:[UIColor whiteColor];
    _content.textColor = selected ? kMainColor:[UIColor lightGrayColor];
    [_check setImage:kImage(selected ? @"check_s":@"check_n") forState:UIControlStateNormal];
}
@end
