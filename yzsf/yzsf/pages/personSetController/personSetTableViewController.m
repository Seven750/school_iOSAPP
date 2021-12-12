//
//  personSetTableViewController.m
//  yzsf
//
//  Created by 卿伟明 on 2021/11/27.
//

#import "personSetTableViewController.h"
#import "personTopCell.h"
#import "personSetCell.h"
#import "util.h"

@interface personSetTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataSource;
@end

@implementation personSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    [self navigationBarAppearanceSet];
    [self tableViewInitialization];
    
}

- (void)navigationBarAppearanceSet{
    NSDictionary *titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:18], NSForegroundColorAttributeName:sRGB(66, 66, 66)};
    if (@available(iOS 13.0, *)) {
        //标题的设置在ios13之后有新的方法，之前的不适用了，要注意！！！
     UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
     appearance.backgroundColor = [UIColor whiteColor];
     appearance.titleTextAttributes = titleTextAttributes;
        self.navigationItem.standardAppearance = appearance;
        self.navigationItem.scrollEdgeAppearance = appearance;
    } else {
     // Fallback on earlier versions
        self.navigationController.navigationBar.barTintColor = sRGB(240, 240, 240);
        [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)tableViewInitialization{
    
    //测试数据源代码
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    
    dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"personPic_man_icon",@"personPic",@"小卿同学",@"personName",nil];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    
    NSArray *titleArr = @[@"账号与安全",@"地址设置",@"软件模式",@"隐私设置",@"消息通知",@"通用",@"帮助与反馈",@"关于"];
    
    dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:titleArr,@"titleArr",nil];
    
    self.dataSource = [NSMutableArray arrayWithObjects:dic1,dic2, nil];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    [self.tableV registerNib:[UINib nibWithNibName:@"personTopCell" bundle:nil] forCellReuseIdentifier:@"personTopCell"];
    [self.tableV registerNib:[UINib nibWithNibName:@"personSetCell" bundle:nil] forCellReuseIdentifier:@"personSetCell"];
    
    //解决tableView被底部tabbar遮挡的问题
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //隐藏table下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        NSArray *titleArr = [self.dataSource[section] valueForKey:@"titleArr"];
        return titleArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        personTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personTopCell" forIndexPath:indexPath];
        cell.personPic.image = [UIImage imageNamed:@"personPic_man_icon"];
        cell.personName.text = @"小卿同学";
        return cell;
    }else{
        personSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personSetCell" forIndexPath:indexPath];
        NSArray *titleArr = [self.dataSource[indexPath.section] valueForKey:@"titleArr"];
        cell.title.text = titleArr[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld行",indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }else{
        return 54;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
