//
//  RecommendChooseCell.m
//  KKJob
//
//  Created by Jason on 2019/1/30.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "RecommendChooseCell.h"

@implementation RecommendChooseCell

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
    _content.textColor = selected ? kMainColor:[UIColor lightGrayColor];
    _check.hidden = !selected;
}


@end
