//
//  TopNewsViewController.m
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "TopNewsViewController.h"
#import "SWRevealViewController.h"
#import <UIKit/UIKit.h>
#import "UIColor+Expanded.h"
#import "MainViewController.h"
@interface TopNewsViewController ()

@end

@implementation TopNewsViewController
@synthesize appDelegate,topnewsVO;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"News Article";
    [titleLabel setTextColor:[UIColor whiteColor]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,30,30)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[UIColor colorWithHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];

    UIFont * font3 =[UIFont fontWithName:@"OpenSans-Bold" size:16.0f];
    UIFont * font2 =[UIFont fontWithName:@"Open Sans" size:14.0f];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*.12, screenRect.size.width*.96,screenRect.size.height*.08)];
    [titleLbl setText:[NSString stringWithFormat:@"%@",topnewsVO.title]];
    titleLbl.font=font3;
    titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    titleLbl.numberOfLines = 0;
    titleLbl.clipsToBounds = YES;
    [titleLbl setTextColor:[UIColor blackColor]];
    [self.view addSubview:titleLbl];
    
    UILabel *descriptionLbl=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*.02,screenRect.size.height*.22, screenRect.size.width*.96,screenRect.size.height*.77)];
    [descriptionLbl setText:[NSString stringWithFormat:@"%@",topnewsVO.descriprions]];
    descriptionLbl.font=font2;
    [descriptionLbl setTextColor:[UIColor blackColor]];
    descriptionLbl.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLbl.numberOfLines = 0;
    descriptionLbl.clipsToBounds = YES;
    [descriptionLbl sizeToFit];
    [self.view addSubview:descriptionLbl];
}
-(IBAction)CancelAction:(id)sender{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];
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
