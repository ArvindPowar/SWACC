//
//  TopNewsViewController.h
//  SWACC
//
//  Created by Infinitum on 09/11/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TopNewsVO.h"
@interface TopNewsViewController : UIViewController
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) TopNewsVO *topnewsVO;
@end
