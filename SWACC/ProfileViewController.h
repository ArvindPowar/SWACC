//
//  ProfileViewController.h
//  Census
//
//  Created by Infinitum on 25/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ProfileViewController : UIViewController
@property(nonatomic,retain)UILabel *firstnameLbl,*lastnameLbl,*emailLbl;
@property(nonatomic,retain)UITextField *firstnameTxt,*lastnameTxt,*emailtxt;
@property (nonatomic, retain)  UISwitch *fingerLogin,*offlineSwitch;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(strong,nonatomic) NSString *tokenStr,*idcardsYes;

@end
