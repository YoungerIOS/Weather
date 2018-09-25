//
//  BYDailyViewController.m
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYDailyViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+FJImage.h"
#import "UIColor+FJColor.h"
#import "BYWeatherDataRequest.h"


@interface BYDailyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dailyModelArray;
@property (nonatomic, strong) BYWeatherDataRequest *request;


@end

@implementation BYDailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置表视图
    [self setUpTableView];
    
    //加载数据
    [self updateTableView];
    

}

- (void)updateTableView {
    
    NSDictionary *weatherData = [[NSUserDefaults standardUserDefaults] objectForKey:@"weatherData"];
    self.dailyModelArray = [BYWeatherModel weatherFromJson:weatherData isHourly:NO];
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
    
    if (self.dailyModelArray.count == 0) {
        return 7;
    }
    return self.dailyModelArray.count;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat widthW = self.view.bounds.size.width;
    CGFloat heightH = 60;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthW, heightH)];
    headerView.backgroundColor = Tint_COLOR;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthW, 45)];
    [headerView addSubview:headerLabel];
    
    headerLabel.text = @"Daily Forecast";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];

    
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"DailyCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    //设置cell背景颜色
//        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    //不可选
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = Tint_COLOR;
    
    BYWeatherModel *weather = self.dailyModelArray[indexPath.row];
    [self configureCell:cell weather:weather indexPath:indexPath];
    
    return cell;
}

#pragma mark -- 设置cell
- (void)configureCell:(UITableViewCell *)cell weather:(BYWeatherModel *)weather indexPath:(NSIndexPath *)indexPath {
    
    //textLabel.text
    cell.textLabel.text = [NSString stringWithFormat:@"%@", weather.date];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
    //imageView.image
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:weather.iconURLStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    if (weather.iconName) {
        [cell.imageView setImage:[UIImage imageWithOriginalName:weather.iconName]];
    }else {
        [cell.imageView setImage:[UIImage imageWithOriginalName:@"placeholder-1"]];
    }
    
    //2、调整大小
    CGSize itemSize = CGSizeMake(60, 60);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //detailTextLable.text
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f˚C / %.0f˚C", weather.maxTemp, weather.minTemp];
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
