//
//  HomeViewController.h
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURL *rest_url;
}
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)UIButton *topnewsBtn,*listserveBtn,*eplBtn,*titleBtn,*contactBtn;
@property(nonatomic,retain)NSMutableArray *menuNameArray,*serachArray;
@property(nonatomic,retain) IBOutlet UITableView *tableViewMain;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,retain)NSString *commonUrl;
@end
