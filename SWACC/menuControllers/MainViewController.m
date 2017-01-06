//
//  MainViewController.m
//  CommunicationApp
//
//  Created by mansoor shaikh on 13/04/14.
//  Copyright (c) 2014 MobiWebCode. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "HomeViewController.h"
#import "TopNewsViewController.h"
#import "ListServeViewController.h"
#import "EPLViewController.h"
#import "COntactInfoViewController.h"
#import "MeetingCalendarViewController.h"
#import "ChatUserListViewController.h"
#import "LoginViewController.h"
#import "MemberpolicyViewController.h"
#import "RegistrationViewController.h"
@interface MainViewController ()<SWRevealViewControllerDelegate>

@end

@implementation MainViewController
@synthesize viewController = _viewController;
@synthesize appDelegate,index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - SWRevealViewDelegate

#define LogDelegates 0
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeftSideMostRemoved ) str = @"FrontViewPositionLeftSideMostRemoved";
    if ( position == FrontViewPositionLeftSideMost) str = @"FrontViewPositionLeftSideMost";
    if ( position == FrontViewPositionLeftSide) str = @"FrontViewPositionLeftSide";
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}

- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated
{
    NSLog( @"%@: %@, %d", NSStringFromSelector(_cmd), viewController, operation);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate=[[UIApplication sharedApplication] delegate];
    RearViewController *rearViewController = [[RearViewController alloc] init];
    UINavigationController *frontNavigationController;
    HomeViewController *home=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];

    TopNewsViewController *Topnews=[[TopNewsViewController alloc] initWithNibName:@"TopNewsViewController" bundle:nil];
    ListServeViewController *listserve=[[ListServeViewController alloc] initWithNibName:@"ListServeViewController" bundle:nil];
    EPLViewController *eplview=[[EPLViewController alloc] initWithNibName:@"EPLViewController" bundle:nil];
    COntactInfoViewController *Contact=[[COntactInfoViewController alloc] initWithNibName:@"COntactInfoViewController" bundle:nil];

    MeetingCalendarViewController *meeting;
        meeting=[[MeetingCalendarViewController alloc] initWithNibName:@"MeetingCalendarViewController" bundle:nil];
    ChatUserListViewController *Chat=[[ChatUserListViewController alloc] initWithNibName:@"ChatUserListViewController" bundle:nil];
    LoginViewController *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    MemberpolicyViewController *Members=[[MemberpolicyViewController alloc] initWithNibName:@"MemberpolicyViewController" bundle:nil];

    RegistrationViewController *profile=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];

    if(appDelegate.index==0)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:home];
//    else if(appDelegate.index==1)
//        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:Topnews];
//    else if(appDelegate.index==2)
//        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:listserve];
//    else if(appDelegate.index==3)
//            frontNavigationController = [[UINavigationController alloc] initWithRootViewController:eplview];
    else if(appDelegate.index==1)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:Chat];
    else if(appDelegate.index==5)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:Contact];
    else if(appDelegate.index==10)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:Members];
    else if(appDelegate.index==11)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:Members];
    else if(appDelegate.index==13)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:Members];
    else if(appDelegate.index==14)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:profile];
    else if(appDelegate.index==12)
        frontNavigationController = [[UINavigationController alloc] initWithRootViewController:Contact];

    else if(appDelegate.index==6){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    frontNavigationController = [[UINavigationController alloc] initWithRootViewController:login];
    }
//        [prefs synchronize];
//        appDelegate.indexs=0;
  //  }
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    
    self.viewController = revealController;
    
    [[[UIApplication sharedApplication] delegate] window].rootViewController = self.viewController;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
