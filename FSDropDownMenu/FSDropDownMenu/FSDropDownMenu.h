//
//  FSDropDownMenu.h
//  FSDropDownMenu
//
//  Created by xiang-chen on 14/12/17.
//  Copyright (c) 2014年 chx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSDropDownMenu;

@protocol FSDropDownMenuDataSource <NSObject>

@required
- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - delegate
@protocol FSDropDownMenuDelegate <NSObject>
@optional
- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface FSDropDownMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UIView *transformView;

@property (nonatomic, weak) id <FSDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <FSDropDownMenuDelegate> delegate;

- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;

-(void)menuTapped;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
