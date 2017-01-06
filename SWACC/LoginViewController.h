//
//  LoginViewController.h
//  SWACC
//
//  Created by Infinitum on 19/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <Security/Security.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    LAContext *cont;
    IBOutlet UIButton *login_bt;
    NSMutableData *_responseData;
    NSURL *rest_url;
    
}
@property(nonatomic,retain)UITextField *usernameTxt,*passwordTxt;
@property(nonatomic,retain)UIButton *submitBtn;
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,readwrite) int counter;
@property(nonatomic,readwrite) BOOL hrliftWS;
@property(nonatomic,retain)NSString * tokenStr;


@end
