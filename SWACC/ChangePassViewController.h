//
//  ChangePassViewController.h
//  SWACC
//
//  Created by Infinitum on 19/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChangePassViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURL *rest_url;
    
}
@property(nonatomic,retain)UITextField *usernameTxt,*oldpasswordTxt,*newpasswordTxt,*confirmPasswordTxt;
@property(nonatomic,retain)UIButton *submitBtn;
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(nonatomic,retain)UIImageView *activityImageView;

@end
