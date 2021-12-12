//
//  homepageViewController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/26.
//

#import "homepageViewController.h"
#import "util.h"
#import "homepageCollectionViewCell.h"
#import "resourcePlatformViewController.h"
#import "websiteWebController.h"

#define scrollView_width  CGRectGetWidth(self.scrollView.frame)
#define scrollView_heitht  CGRectGetHeight(self.scrollView.frame)

@interface homepageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *contentList;    //数组contentList内包含要显示照片名称。

@property (weak, nonatomic) IBOutlet UIPageControl *imgViewControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (strong,nonatomic) NSTimer *myTimer;
@property (strong,nonatomic) NSMutableArray *cellNameArr;
@end

@implementation homepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"校园主页";
    self.tabBarController.tabBar.hidden = NO;
    
    //测试数据代码
    self.contentList = [NSMutableArray arrayWithArray:@[@"topPic1", @"topPic2", @"topPic3", @"topPic4", @"topPic5",@"topPic6"]];
    
    self.cellNameArr = [NSMutableArray arrayWithObjects:@"主页",@"一卡通",@"预约",@"资源平台",@"综合服务",@"报修", nil];
    
    
    
    //设置collectionView的样式
    [self collectionViewSet:[self collectionViewLayoutSet]];
    
    //设置pagecontroll
    self.imgViewControl.numberOfPages = self.contentList.count;
    self.imgViewControl.currentPage = 0;
    
    // 2.将scrollView添加到view 设定控制器背景颜色
    [self.topView addSubview:self.scrollView];
    self.topView.backgroundColor = [UIColor whiteColor];
    
    //将pictures添加到scrollView中
    [self addPicsToScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addTimer];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.myTimer invalidate];
    self.myTimer = nil;
    
    
}


#pragma mark -collectionView Set


- (UICollectionViewFlowLayout *)collectionViewLayoutSet
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREENWIDTH -28)/3, 100);//每一个cell的大小
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向
//    CGFloat margin = (SCREENWIDTH - 80) *0.5;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//四周的边距
    //设置最小边距   line是滚动方向的cell之间   另一个是垂直于滚动方向cell之间的间距
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 4;
    
    return layout;
}

- (void)collectionViewSet:(UICollectionViewFlowLayout *)layout
{
    //创建UICollectionView
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"homepageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"homepageCollectionViewCell"];
    self.collectionViewHeight.constant = 240;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}




#pragma mark -scrollView Set

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.topView.frame), CGRectGetHeight(self.topView.frame))];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.topView.frame) * (self.contentList.count + 2), CGRectGetHeight(self.topView.frame));
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        //显示滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        //设置起始的偏移量
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [_scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.topView.frame), 0, CGRectGetWidth(self.topView.frame), CGRectGetHeight(self.topView.frame)) animated:NO];
    }
    return _scrollView;
}

- (void)addPicsToScrollView{
    
    for (NSUInteger i=0; i<self.contentList.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView_width * (i+1), 0, scrollView_width, scrollView_heitht)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:self.contentList[i]];
        [self.scrollView addSubview:imageView];
    }
    //取最后一张图片放在第0页
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView_width, scrollView_heitht)];
    firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    firstImageView.image = [UIImage imageNamed:[self.contentList lastObject]];
    [self.scrollView addSubview:firstImageView];
    
    //取第一张图片放在最后一页
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView_width *(self.contentList.count+1), 0, scrollView_width, scrollView_heitht)];
    lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    lastImageView.image = [UIImage imageNamed:[self.contentList firstObject]];
    [self.scrollView addSubview:lastImageView];
}

#pragma mark--------轮播图实现，UIPageControl控制自动轮播---
//自动轮播图播放
- (void)turnPage {
    NSInteger page = self.imgViewControl.currentPage; // 获取当前的page
    if (page == 0) {
        //这时候因为有动画，先到第七张图
        [self.scrollView scrollRectToVisible:CGRectMake(scrollView_width * (self.contentList.count +1),0,scrollView_width,scrollView_heitht) animated:YES];
    }else if(page== 1){
        //这时候在第七张图，然后到第一张图，再通过动画到第二张图，避免出现动画在scrowlView回滚到现象
        [self.scrollView scrollRectToVisible:CGRectMake(scrollView_width,0,scrollView_width,scrollView_heitht) animated:NO];
        [self.scrollView scrollRectToVisible:CGRectMake((scrollView_width) *2,0,scrollView_width,scrollView_heitht) animated:YES];
    }else{
        [self.scrollView scrollRectToVisible:CGRectMake((scrollView_width) *(page+1),0,scrollView_width,scrollView_heitht) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
    }
}

- (void)runTimePage {
    NSInteger page = self.imgViewControl.currentPage; // 获取当前的page
    page++;
    page = page > (self.contentList.count - 1) ? 0 : page;
    self.imgViewControl.currentPage = page;
    [self turnPage];
}

- (void)addTimer {
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}


#pragma mark -scrollViewDelegate -
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //关闭定时器,避免与手动滑动冲突
    [self.myTimer invalidate];
    self.myTimer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //当手动滑动结束后,开启定时器
    [self addTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = floor((scrollView.contentOffset.x - scrollView_width/2)/scrollView_width) + 1;
    //因为此时从第二页开始 所以要减一下
    page--;
    
    self.imgViewControl.currentPage = page%6;
    if (page%6 ==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(scrollView_width,0,scrollView_width,scrollView_heitht) animated:NO]; // 序号0 最后1页
    }
    else if (page%6 == -1)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(scrollView_width * (self.contentList.count),0,scrollView_width,scrollView_heitht) animated:NO]; // 最后+1,循环第1页
        self.imgViewControl.currentPage = self.contentList.count;
    }
    
}

#pragma mark - CollectionViewDelegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    homepageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homepageCollectionViewCell" forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"homepageIcon_%ld", indexPath.row + 1];
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.label.text = self.cellNameArr[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%ld个按钮",indexPath.row);
    if (indexPath.row == 0) {
        websiteWebController *ctrl = [[websiteWebController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    if (indexPath.row == 1) {
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setValue:@((long)0) forKey:@"error_code"];
//        
//        if ([[dic valueForKey:@"error_code"] longValue] != 0) {
//            NSLog(@"11111");
//        }else{
//            NSLog(@"22222");
//        }
        
    }
    if (indexPath.row == 3) {
        resourcePlatformViewController *ctr = [[resourcePlatformViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

- (IBAction)imgViewConrtolClick:(id)sender {
    NSUInteger page = self.imgViewControl.currentPage;
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = self.scrollView.frame.origin.y;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
}

@end
