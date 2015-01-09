//
//  ViewController.m
//  FSDropDownMenu
//
//  Created by xiang-chen on 14/12/17.
//  Copyright (c) 2014年 chx. All rights reserved.
//

#import "ViewController.h"
#import "FSDropDownMenu.h"

@interface ViewController ()<FSDropDownMenuDataSource,FSDropDownMenuDelegate>
@property(nonatomic,strong) NSArray *cityArr;
@property(nonatomic,strong) NSArray *areaArr;
@property(nonatomic,strong) NSArray *currentAreaArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FSDropDownMenu";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.f];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 30)];
    activityBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [activityBtn setTitle:@"附近" forState:UIControlStateNormal];
    [activityBtn setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
    activityBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 52, 11, 0);
    [activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activityBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityBtn];
    
    _cityArr = @[@"附近",@"上海",@"北京",@"同城"];
    _areaArr = @[
                 @[@"附近",@"500米",@"1000米",@"2000米",@"5000米"],
                 @[@"徐家汇",@"人民广场",@"陆家嘴"],
                 @[@"三里屯",@"亚运村",@"朝阳公园"],
                 @[@"同城"],
                 ];
    _currentAreaArr = _areaArr[0];
    FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:300];
    menu.transformView = activityBtn.imageView;
    menu.tag = 1001;
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
}

-(void)btnPressed:(id)sender{
    FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
    [UIView animateWithDuration:0.2 animations:^{

    } completion:^(BOOL finished) {
        [menu menuTapped];
    }];
}

#pragma mark - reset button size

-(void)resetItemSizeBy:(NSString*)str{
    UIButton *btn = (UIButton*)self.navigationItem.rightBarButtonItem.customView;
    [btn setTitle:str forState:UIControlStateNormal];
    NSDictionary *dict = @{NSFontAttributeName:btn.titleLabel.font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y,size.width+33, 30);
    btn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+23, 11, 0);
}


#pragma mark - FSDropDown datasource & delegate

- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == menu.leftTableView) {
        return _cityArr.count;
    }else{
        return _currentAreaArr.count;
    }
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == menu.leftTableView) {

        return _cityArr[indexPath.row];
    }else{
        return _currentAreaArr[indexPath.row];
    }
}


- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == menu.leftTableView){
        _currentAreaArr = _areaArr[indexPath.row];
        [menu.rightTableView reloadData];
    }else{
        [self resetItemSizeBy:_currentAreaArr[indexPath.row]];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
