//
//  TabBarGeRenViewController.m
//  Communication
//
//  Created by helloworld on 15/2/9.
//  Copyright (c) 2015年 JL. All rights reserved.
//

#import "TabBarGeRenViewController.h"
#import "Maillist.h"             //通讯录   【个人】
#import "DialViewController.h"   //拨号盘
#import "Callrecords.h"          //动态记录
//#import "Thecalendar.h"          //日历

#import "CKDemoViewController.h"
@interface TabBarGeRenViewController ()
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation TabBarGeRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[Maillist alloc]init]];
    _nav1 = [[UINavigationController alloc] initWithRootViewController:[[DialViewController alloc] init]];
    
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:[[Callrecords alloc] init]];
    

//    UINavigationController* nave = [[UINavigationController alloc] initWithRootViewController:[[ Thecalendar alloc] init]];
    
    self.viewController = [CKDemoViewController new];
    
    //    通讯录   【个人】
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:[UIImage imageNamed:@"contact-gray@2x.png"]selectedImage:[UIImage imageNamed:@"contact-blue@2x.png"]];
    
    //    拨号盘
    _nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"拨号盘" image:[UIImage imageNamed:@"keyboard-gray@2x.png"] selectedImage:[UIImage imageNamed:@"keyboard-blue@2x.png"]];
    
    //    动态记录
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"动态记录" image:[UIImage imageNamed:@"recentdynamic-gray@2x.png"] selectedImage:[UIImage imageNamed:@"recentdynamic-blue@2x.png"]];
    
    //    日历
    self.viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"日历" image:[UIImage imageNamed:@"calender-gray@2x.png"] selectedImage:[UIImage imageNamed:@"calender-blue@2x.png"]];
    
    self.viewControllers = @[nav,_nav1,nav2,self.viewController];

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