//
//  pageLoadingView.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/7.
//

#import "pageLoadingView.h"
#import "Masonry.h"

@interface pageLoadingView()
@property (strong,nonatomic) UILabel *infoLabel;
@end

@implementation pageLoadingView

static pageLoadingView *loadingView = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadingView = [[pageLoadingView alloc] init];
    });
//    if (loadingView == nil) {
//            loadingView = [[pageLoadingView alloc] init];
//        }
    return loadingView;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        //------- loading imageView -------//
        UIImageView *loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        [self addSubview:loadingImageView];
        loadingImageView.image = [UIImage imageNamed:@"loading_pic1"];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 1; i < 54; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"loading_pic%d",i];
            [imageArray addObject:[UIImage imageNamed:imageName]];
        }
        loadingImageView.animationImages = imageArray;
        loadingImageView.animationDuration = 1.6;
        loadingImageView.animationRepeatCount = 0;
        [loadingImageView startAnimating];
        [loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(260, 200));
        }];
        
        //------- 说明文本 -------//
        _infoLabel = [[UILabel alloc] init];
        [self addSubview:_infoLabel];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.font = [UIFont systemFontOfSize:14];
        _infoLabel.textColor = [UIColor blackColor];
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(loadingImageView);
            make.top.mas_equalTo(loadingImageView.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(18);
        }];
    }
    return self;
}

#pragma mark - 赋值loading说明信息
/** 赋值loading说明信息 */
- (void)setLoadingInfo:(NSString *)loadingInfo{
    _loadingInfo = loadingInfo;
    _infoLabel.text = _loadingInfo;
}


//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    return [pageLoadingView sharedInstance];
//}
//
//- (id)copyWithZone:(struct _NSZone *)zone {
//    return [pageLoadingView sharedInstance];
//}

@end
