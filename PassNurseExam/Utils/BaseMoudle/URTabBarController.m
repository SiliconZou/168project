//
//  URTabBarController.m
//  PassNurseExam
//
//  Created by qc on 2019/9/9.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "URTabBarController.h"

#import "HomePageViewController.h"
#import "QuestionBankViewController.h"
#import "PersonalCenterViewController.h"
#import "LivingViewController.h"
#import "CourseViewController.h"
#import "CircleViewController.h"

@interface URTabBarController ()<UITabBarControllerDelegate>

@end

@implementation URTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self   initializeTabBar] ;
    
}

-(void)initializeTabBar {
    
    [[UITabBarItem  appearance] setTitleTextAttributes:@{
                                                         NSForegroundColorAttributeName:UR_ColorFromValue(0x666666)
                                                         } forState:UIControlStateNormal];
    
    [[UITabBarItem   appearance] setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName:UR_ColorFromValue(0xFF754C)
                                                          } forState:UIControlStateSelected];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    if (@available(iOS 13.0,*)) {
        [[UITabBar appearance] setUnselectedItemTintColor:UR_ColorFromValue(0x666666)];
    }
//    self.tabBar.backgroundImage = [UIImage  imageNamed:@"footer_bg"];
    
    self.tabBar.shadowImage = [UIImage  ur_imageWithColor:UR_ColorFromValue(0xFDFDFD)] ;
    
    NSMutableArray *marrTemp = [[NSMutableArray alloc]init];
    
    marrTemp = [self addArrVC:marrTemp];
    
    marrTemp = [self addItemInfo:marrTemp];
    
    NSMutableArray *marrViewController = [[NSMutableArray alloc]init];
    int count = is_online == 0 ? 3 : 5;
    for (int i = 0; i < count; i++){
        UIViewController *controller = marrTemp[0][i];
        controller.tabBarItem.title = marrTemp[1][i];
        controller.tabBarItem.image = [UIImage ur_imageWithOriginalName:marrTemp[2][i]];
        controller.tabBarItem.selectedImage = [UIImage ur_imageWithOriginalName:marrTemp[3][i]];
        [controller.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
        controller.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];

        [marrViewController addObject:nav];
    }
    self.viewControllers = marrViewController;
    
    self.tabBar.opaque = YES;
    
    self.delegate = self ;
    
    //默认选中我的
    [self setSelectedIndex:0];
    
}

-(NSMutableArray *)addArrVC:(NSMutableArray *)marrTemp{
    
    HomePageViewController * homePageViewController = [[HomePageViewController alloc] init];
    
    QuestionBankViewController * qbViewController = [[QuestionBankViewController alloc] init];
    
    PersonalCenterViewController * personalViewController=[[PersonalCenterViewController alloc]init];
    
//    LivingViewController * livingViewController = [[LivingViewController alloc] init];
    CircleViewController * circleViewController = [[CircleViewController alloc] init];
    CourseViewController * courseViewController = [[CourseViewController alloc] init];

    //livingViewController
//    NSArray *arrController;
//    if (is_online == 0) {
//        arrController = [NSArray arrayWithObjects:homePageViewController,qbViewController,livingViewController,personalViewController, nil];
//    } else {
//        CourseViewController * courseViewController = [[CourseViewController alloc] init];
//        arrController = [NSArray arrayWithObjects:homePageViewController,qbViewController,courseViewController,livingViewController,personalViewController, nil];
//    }
    NSArray *arrController = is_online == 0 ? [NSArray arrayWithObjects:homePageViewController,qbViewController,personalViewController, nil] : [NSArray arrayWithObjects:homePageViewController,qbViewController,courseViewController,circleViewController,personalViewController, nil];;
    
    [marrTemp addObject:arrController];
    
    return marrTemp;
}

#pragma mark - 添加页面相关信息
- (NSMutableArray *)addItemInfo:(NSMutableArray *)marrTemp{
    NSArray *arrTitle = is_online == 0 ? @[@"首页",@"题库",@"个人中心"] : @[@"首页",@"题库",@"课程",@"圈子",@"我的"];//
    NSArray *arrImageNormal = is_online == 0 ? @[@"tabicon1",@"tabicon2",@"tabicon5"] : @[@"tabicon1",@"tabicon2",@"tabicon3",@"tabicon4",@"tabicon5"];//
    NSArray *arrImageSelected = is_online == 0 ? @[@"tabicon1s",@"tabicon2s",@"tabicon5s"] :@[@"tabicon1s",@"tabicon2s",@"tabicon3s",@"tabicon4s",@"tabicon5s"];//
    NSArray *arrInfo = @[arrTitle,arrImageNormal,arrImageSelected];
    [marrTemp addObjectsFromArray:arrInfo];
    
    return marrTemp;
}

@end
