//
//  personTopCell.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/27.
//

#import "personTopCell.h"

@implementation personTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.personPic.layer.cornerRadius = 29;
    self.personPic.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
