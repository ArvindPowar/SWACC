//
//  ListServeViewController.h
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ListServeViewController : UIViewController
@property(nonatomic,retain) AppDelegate *appDelegate;

@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)UIButton *topnewsBtn,*listserveBtn,*eplBtn,*titleBtn,*contactBtn;

@end
