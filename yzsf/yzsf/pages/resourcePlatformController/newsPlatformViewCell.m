//
//  newsPlatformViewCell.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/2.
//

#import "newsPlatformViewCell.h"
#import "UIImageView+WebCache.h"

@implementation newsPlatformViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)cellSetByTopNewsResponse:(TopNewsResponse *)res
{
    self.titleLbl.text = res.title;
    self.newsFromLbl.text = res.author_name;
    self.newsTimeLbl.text = res.date;
    
//    [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:res.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:@"loading_icon"]];
//    [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:res.thumbnail_pic_s02] placeholderImage:[UIImage imageNamed:@"loading_icon"]];
//    [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:res.thumbnail_pic_s03] placeholderImage:[UIImage imageNamed:@"loading_icon"]];
    
    if (res.thumbnail_pic_s) {
        [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:res.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:@"loading_icon"]];
        self.imgView1.hidden = NO;
    }else{
        self.imgView1.hidden = YES;
    }
    if (res.thumbnail_pic_s02) {
        [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:res.thumbnail_pic_s02] placeholderImage:[UIImage imageNamed:@"loading_icon"]];
        self.imgView2.hidden = NO;
    }else{
        self.imgView2.hidden = YES;
    }
    if (res.thumbnail_pic_s03) {
        [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:res.thumbnail_pic_s03] placeholderImage:[UIImage imageNamed:@"loading_icon"]];
        self.imgView3.hidden = NO;
    }else{
        self.imgView3.hidden = YES;
    }
}

@end
