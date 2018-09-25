//
//  BYHourlyViewController.m
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYHourlyViewController.h"
#import "UIImageView+WebCache.h"
#import "UIColor+FJColor.h"
#import "UIImage+FJImage.h"
#import "BYWeatherDataRequest.h"


@interface BYHourlyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *hourlyModelArray;
@property (nonatomic, strong) BYWeatherDataRequest *dataRequest;
@end

@implementation BYHourlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置表视图
    [self setUpTableView];
    
    //加载数据
    [self updteTableView];
    

}

- (void)updteTableView {
    
    NSDictionary *weatherData = [[NSUserDefaults standardUserDefaults] objectForKey:@"weatherData"];
    self.hourlyModelArray = [BYWeatherModel weatherFromJson:weatherData isHourly:YES];
    
    [self.tableView reloadData];
}

#pragma mark -- 初始化表视图/头部视图
- (void)setUpTableView {

    //创建table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 44;
    //加载table view
    [self.view addSubview:self.tableView];
    
    //分割线
    self.tableView.separatorColor = [UIColor purpleColor];
    //page分页设置
    self.tableView.pagingEnabled = YES;
}

#pragma mark -- tableView dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.hourlyModelArray.count == 0) {
        return 8;
    }
    return self.hourlyModelArray.count;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat widthW = self.view.bounds.size.width;
    CGFloat heightH = 60;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthW, heightH)];
    headerView.backgroundColor = Tint_COLOR;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthW, 45)];
    [headerView addSubview:headerLabel];
    
    headerLabel.text = @"Hourly Forecast";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];

    
    return headerView;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"HourlyCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
//    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    //不可选
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = Tint_COLOR;
    
    //每小时第一行
    BYWeatherModel *weather = self.hourlyModelArray[indexPath.row];
    [self configureCell:cell weather:weather indexPath:indexPath];
    
    return cell;
}

#pragma mark -- 设置cell
- (void)configureCell:(UITableViewCell *)cell weather:(BYWeatherModel *)weather indexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.text = [NSString stringWithFormat:@"%.0f:00", weather.hourly];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:36];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:weather.iconURLStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    if (weather.iconName) {
        [cell.imageView setImage:[UIImage imageWithOriginalName:weather.iconName]];
    }else {
        [cell.imageView setImage:[UIImage imageWithOriginalName:@"placeholder-1"]];
    }

    //调整大小
    CGSize itemSize = CGSizeMake(60, 60);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f˚C", weather.temp];
    cell.detailTextLabel.textColor = Tint_COLOR;
    
}

#pragma mark -- tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return ([UIScreen mainScreen].bounds.size.height - TabBarHeight - NavBarHeight) / (CGFloat)cellCount;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
