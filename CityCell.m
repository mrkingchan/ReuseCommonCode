//
//  CityCell.m
//  KKJob
//
//  Created by Jason on 2019/1/30.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setCellWithContent:(NSString *)content selected:(BOOL)selected {
    _content.text = content;
    
    _content.textColor = selected ? kMainColor:[UIColor lightGrayColor];
    self.backgroundColor = selected ? [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]:[UIColor whiteColor];
}

@end
