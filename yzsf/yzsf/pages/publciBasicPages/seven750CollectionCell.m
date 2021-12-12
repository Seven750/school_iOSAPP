//
//  seven750CollectionCell.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/2.
//

#import "seven750CollectionCell.h"

@implementation seven750CollectionCell

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:(229/ 255.0) green:(229 / 255.0) blue:(229/ 255.0) alpha:1.0];
    } else {
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backgroundColor = [UIColor whiteColor];
        } completion:nil];
    }
}

// 设置选中选中
-(void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}


@end
