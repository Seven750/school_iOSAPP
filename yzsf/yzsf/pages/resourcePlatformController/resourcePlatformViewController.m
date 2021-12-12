//
//  resourcePlatformViewController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/30.
//

#import "resourcePlatformViewController.h"
#import "resourcePlatformModel.h"
#import "topPlatformViewCell.h"
#import "newsPlatformViewCell.h"
#import "topPlatformCollectionViewCell.h"


@interface resourcePlatformViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (strong,nonatomic) NSMutableArray *dataSourceT;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (strong,nonatomic) NSMutableArray *dataSourceC;
@property (strong,nonatomic) resourcePlatformModel *model;
@end

@implementation resourcePlatformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"资源平台";
    [util showLoading];
    //model的初始化
    self.model = [[resourcePlatformModel alloc] init];
    self.dataSourceT = [[NSMutableArray alloc] init];
    
    //初始化tableView的内容
    [self tableViewInitialization];
    
    //初始化collectionView内容
    self.dataSourceC = [[NSMutableArray alloc] initWithArray:@[@"兼职信息",@"软件资源",@"失物招领",@"影视资源",@"校内二手",@"其他功能"]];
    [self collectionViewInitialization];
}

- (void)tableViewInitialization
{
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    [self.tableV registerNib:[UINib nibWithNibName:@"topPlatformViewCell" bundle:nil] forCellReuseIdentifier:@"topPlatformViewCell"];
    [self.tableV registerNib:[UINib nibWithNibName:@"newsPlatformViewCell" bundle:nil] forCellReuseIdentifier:@"newsPlatformViewCell"];
    //隐藏table下划线
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getTopNewsInfo];
}

- (void)getTopNewsInfo{
    [self.model getTopNewsInfoPage:1 Block:^(NSMutableArray * _Nonnull resultArr) {
        
        self.dataSourceT = [[NSMutableArray alloc] initWithArray:resultArr];
        [util dismissLoading];
        [self.tableV reloadData];
    }];
}

- (void)collectionViewInitialization
{
    //创建UICollectionView
    [self.collectionV setCollectionViewLayout:[self.model collectionViewLayoutSet]];
    self.collectionV.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [self.collectionV registerNib:[UINib nibWithNibName:@"topPlatformCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"topPlatformCollectionViewCell"];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceT.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        topPlatformViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topPlatformViewCell"];
//        if (indexPath.row ==0) {
//            cell.label1.text = @"兼职信息";
//            cell.imgView1.image = [UIImage imageNamed:@"partTimeJob_icon"];
//            cell.label2.text = @"失物招领";
//            cell.imgView2.image = [UIImage imageNamed:@"lostAndFound_icon"];
//            cell.label3.text = @"校内二手";
//            cell.imgView3.image = [UIImage imageNamed:@"secondHand_icon"];
//        }else{
//            cell.label1.text = @"软件资源";
//            cell.imgView1.image = [UIImage imageNamed:@"softwareResources_icon"];
//            cell.label2.text = @"影视资源";
//            cell.imgView2.image = [UIImage imageNamed:@"movieResources_icon"];
//            cell.label3.text = @"其他功能";
//            cell.imgView3.image = [UIImage imageNamed:@"othersResources_icon"];
//        }
//        return cell;
//    }else{
        newsPlatformViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsPlatformViewCell"];
        [cell cellSetByTopNewsResponse:self.dataSourceT[indexPath.row]];
        
        return cell;
//    }
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceC.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    topPlatformCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topPlatformCollectionViewCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.imgView.image = [UIImage imageNamed:@"partTimeJob_icon"];
            break;
        case 1:
            cell.imgView.image = [UIImage imageNamed:@"softwareResources_icon"];
            break;
        case 2:
            cell.imgView.image = [UIImage imageNamed:@"lostAndFound_icon"];
            break;
        case 3:
            cell.imgView.image = [UIImage imageNamed:@"movieResources_icon"];
            break;
        case 4:
            cell.imgView.image = [UIImage imageNamed:@"secondHand_icon"];
            break;
        case 5:
            cell.imgView.image = [UIImage imageNamed:@"othersResources_icon"];
            break;
        default:
            break;
    }
    cell.funtionName.text = self.dataSourceC[indexPath.row];
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%ld个按钮",indexPath.row);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;  //scrowView四周的区域
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
//    NSLog(@"offset:%f  bounds:%f  size:%f   inset:%f",offset.y,bounds.size.height,size.height,inset.bottom);

    float reload_distance = -50;
    if (y > h + reload_distance) {
//        NSLog(@"需要加载了");
        [self.model getTopNewsInfoPage:(self.dataSourceT.count/10 + 1) Block:^(NSMutableArray * _Nonnull resultArr) {
            [self.dataSourceT addObjectsFromArray:resultArr];
            [self.tableV reloadData];
        }];
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"拖拽结束了");
//}

@end
