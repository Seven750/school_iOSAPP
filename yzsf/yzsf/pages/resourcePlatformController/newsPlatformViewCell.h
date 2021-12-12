//
//  newsPlatformViewCell.h
//  yzsf
//
//  Created by 卿伟明 on 2021/12/2.
//

#import "seven750TableCell.h"
#import "getTopNews.h"
NS_ASSUME_NONNULL_BEGIN

@interface newsPlatformViewCell : seven750TableCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UILabel *newsFromLbl;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLbl;

-(void)cellSetByTopNewsResponse:(TopNewsResponse *)res;
@end

NS_ASSUME_NONNULL_END
