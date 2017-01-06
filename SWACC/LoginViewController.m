//
//  LoginViewController.m
//  SWACC
//
//  Created by Infinitum on 19/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Expanded.h"
#import "Reachability.h"
#import "MainViewController.h"
#import "ChangePassViewController.h"
#import "LoginVO.h"
#import "RegistrationViewController.h"
#import "UIFont+FontAwesome.h"
#import <EventKit/EventKit.h>
@interface LoginViewController (DummyInterface)<NSURLConnectionDataDelegate>
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@property (strong, nonatomic) NSURLConnection *connection;


@end

@implementation LoginViewController
@synthesize usernameTxt,passwordTxt,submitBtn,appDelegate,activityImageView,counter,hrliftWS,tokenStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:14.0f];
    
    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    //user name text field
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Sign in";
    [titleLabel setTextColor: [UIColor whiteColor]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:14.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f9fcf5"]];
    UIView * backgroundview=[[UIView alloc] init];
    [backgroundview setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height*.50)];
    [backgroundview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backgroundview];

    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.15,screenRect.size.width*0.50,55)];
    [logoImg setImage:[UIImage imageNamed:@"HR-Lift_logo.png"]];
    //[self.view addSubview:logoImg];
    
    usernameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.18,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    usernameTxt.font=font1;
    usernameTxt.textAlignment=NSTextAlignmentLeft;
    usernameTxt.delegate = self;
    usernameTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    //usernameTxt.layer.borderWidth=1.0;
    //usernameTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorders = [CALayer layer];
        bottomBorders.frame = CGRectMake(0.0f, usernameTxt.frame.size.height - 1, usernameTxt.frame.size.width, 1.0f);
        bottomBorders.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [usernameTxt.layer addSublayer:bottomBorders];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    usernameTxt.leftView = paddingView;
    usernameTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * strings = [[NSMutableAttributedString alloc] initWithString:@"Email*"];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,5)];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,1)];
    self.usernameTxt.attributedPlaceholder=strings;
    usernameTxt.returnKeyType=UIReturnKeyNext;
    [self.view addSubview:usernameTxt];
    
    UILabel *usernameicon=[[UILabel alloc]init];
    usernameicon.layer.frame=CGRectMake(screenRect.size.width*0.85,screenRect.size.height*0.27,28,28);
//    usernameicon.textColor=[UIColor lightGrayColor];
//    usernameicon.layer.shadowOpacity = 0.2;
//    usernameicon.alpha=0.5;
//    usernameicon.font = [UIFont fontWithName:@"FontAwesome" size:30];
//    usernameicon.text = @"\uf084";
    [usernameicon setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"password_key_img.png"]]];
    [self.view addSubview:usernameicon];

    //password text field
    passwordTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.27,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    passwordTxt.font=font1;
    passwordTxt.textAlignment=NSTextAlignmentLeft;
    passwordTxt.delegate = self;
    passwordTxt.secureTextEntry = YES;
    //passwordTxt.layer.borderWidth=1.0;
    //passwordTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, passwordTxt.frame.size.height - 1, passwordTxt.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
    [passwordTxt.layer addSublayer:bottomBorder];
    UIView *paddingViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    passwordTxt.leftView = paddingViews;
    passwordTxt.leftViewMode = UITextFieldViewModeAlways;
    passwordTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:@"Password*"];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,8)];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8,1)];
    self.passwordTxt.attributedPlaceholder=stringss;
    passwordTxt.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:passwordTxt];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.035];
    
    //submit button
    UIButton *forgotBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.35,screenRect.size.width*0.39,screenRect.size.height*0.05)];
    forgotBtn.layer.cornerRadius = 6.0f;
    [forgotBtn setTitle:@"Reset Password" forState:UIControlStateNormal];
    [forgotBtn setTitleColor:[UIColor colorWithHexString:@"03687f"] forState:UIControlStateNormal];
    forgotBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [forgotBtn setBackgroundColor:[UIColor whiteColor]];
    [forgotBtn.titleLabel setFont:customFontdregs];
    //[forgotBtn addTarget:self action:@selector(LoginGoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotBtn];

    submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.56,screenRect.size.height*0.35,screenRect.size.width*0.39,screenRect.size.height*0.05)];
    submitBtn.layer.cornerRadius = 6.0f;
    [submitBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"03687f"]];
    [submitBtn.titleLabel setFont:customFontdregs];
    [submitBtn addTarget:self action:@selector(LoginGoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *str=[prefs objectForKey:@"FingerLogin"];
    if ([str isEqualToString:@"YES"] && str !=nil){
        
        //touch id code is here
        [self TouchAction];
        NSMutableAttributedString *yourString = [[NSMutableAttributedString alloc] initWithString:@"Sign in with Touch ID"];
        [yourString addAttribute:NSUnderlineStyleAttributeName
                           value:[NSNumber numberWithInt:1]
                           range:(NSRange){0,21}];
        
        UILabel *tuochTxt=[[UILabel alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.45,screenRect.size.width*0.60,screenRect.size.height*0.05)];
        [tuochTxt setFont:customFontdregs];
        tuochTxt.attributedText=[yourString copy];
        tuochTxt.textAlignment=NSTextAlignmentCenter;
        [tuochTxt setBackgroundColor:[UIColor clearColor]];
        [tuochTxt setTextColor:[UIColor blackColor]];
        [self.view addSubview:tuochTxt];
        
        UIButton * tuochBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.20,screenRect.size.height*0.45,screenRect.size.width*0.60,screenRect.size.height*0.05)];
        tuochBtn.layer.cornerRadius = 6.0f;
        [tuochBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tuochBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //[tuochBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
        [tuochBtn.titleLabel setFont:customFontdregs];
        [tuochBtn setBackgroundColor:[UIColor clearColor]];
        [tuochBtn addTarget:self action:@selector(TouchAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tuochBtn];
    }
    usernameTxt.text=@"powararvind3@gmail.com";
    passwordTxt.text=@"Arvind@1155";
    
   // [self syncWithCalendar];

}
-(void)syncWithCalendar {
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = @"Event Title Testing123"; //give event title you want
        event.startDate = [NSDate date];
        event.endDate = [event.startDate dateByAddingTimeInterval:60*60];
        
        //alarm time in seconds e.g 60 means 1 min.
        EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeInterval:60 sinceDate:event.startDate]];
        // Add the alarm to the event.
        [event addAlarm:alarm];
        

        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
    }];
}

-(IBAction)TouchAction{
    NSError *error;
    NSString *onlock_reason=@"Login to view your SWACC App";
    cont=[[LAContext alloc]init];
    
    if ([cont canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error])
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [cont evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:onlock_reason reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
                    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
                    if(myStatus == NotReachable)
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        
                    }else
                    {
                        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                        appDelegate.index=0;
                        [self.navigationController pushViewController:mainvc animated:YES];
                    }
                });
                [prefs synchronize];
            } else {
                NSString *str=error.description;
                NSLog(@"User error msg %@",str);
                
                if ([str rangeOfString:@"Fallback"].location != NSNotFound) {
                    NSLog(@"Fallback authentication mechanism selected");
                    counter=counter++;
                    if (counter==3 && [str rangeOfString:@"Biometry"].location == NSNotFound) {
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"User don't Want");
                        });
                    }
                }else if ([str rangeOfString:@"canceled by system"].location != NSNotFound)
                {
                    
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"User don't Want");
                    });
                }
            }
        }];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:error.description
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        });
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==usernameTxt){
        [passwordTxt becomeFirstResponder];
    }else if(textField==passwordTxt){
        [passwordTxt resignFirstResponder];
    }
    return YES;
}
-(void)LoginGoBtnClick{
//    ChangePassViewController *changePass=[[ChangePassViewController alloc] initWithNibName:@"ChangePassViewController" bundle:nil];
//    [self.navigationController pushViewController:changePass animated:YES];
//
 //   RegistrationViewController *mainvc=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
 //   [self.navigationController pushViewController:mainvc animated:YES];

   [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *urlString=[prefs objectForKey:@"SWACC"];
    if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
    [self performSelector:@selector(loginWebservices) withObject:nil afterDelay:1.0];
    }else{
    [self performSelector:@selector(LoginGoBtnClicks) withObject:nil afterDelay:1.0];
    }
}

-(void)LoginGoBtnClicks
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:[prefs objectForKey:@"NOINTERNET"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [activityImageView removeFromSuperview];
    }else{
        if ([usernameTxt.text isEqualToString:@""] || [passwordTxt.text isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"User name and Password are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityImageView removeFromSuperview];
        }else{
            NSURL *url;
            NSMutableString *httpBodyString;
            NSMutableURLRequest *urlRequest;
            NSString *urlString;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString* deviceid = [appDelegate.deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString* deviceidsend=[NSString stringWithFormat:@"Iphone%@",deviceid];
            
            httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"email=%@&pwd=%@&device_id=%@",usernameTxt.text,passwordTxt.text,deviceidsend]];
            
            NSString *urlString1=[prefs objectForKey:@"SWACC"];
            if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
                urlString = [[NSString alloc]initWithFormat:@"%@wsLogin.php",[prefs objectForKey:@"SWACC"]];
                url=[[NSURL alloc] initWithString:urlString];
                urlRequest=[NSMutableURLRequest requestWithURL:url];
                [urlRequest setHTTPMethod:@"POST"];
                [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];

            }else{
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setValue:usernameTxt.text forKey:@"email"];
                [dict setValue:passwordTxt.text forKey:@"pwd"];
                [dict setValue:deviceidsend forKey:@"device_id"];
                //convert object to data
                NSError *error;
                NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
                
                urlRequest = [[NSMutableURLRequest alloc] init];
                [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/login"]];
                [urlRequest setHTTPMethod:@"POST"];
                [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [urlRequest setHTTPBody:jsonData];
             }
            
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error)
                {
                    [activityImageView removeFromSuperview];
                    NSLog(@"Failed to submit request");
                }
                else
                {
                    NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                                  length:[data length] encoding: NSUTF8StringEncoding];
                    NSError *error;
                    if ([content isEqualToString:@""]) {
                        [activityImageView removeFromSuperview];
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }else {
                        NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        NSString *result = [[NSString alloc]init];
                        result =[userDict objectForKey:@"result"];
                        NSString *message = [[NSString alloc]init];
                        message = [userDict objectForKey:@"message"];
                        int boolValue =[result intValue];
                        if (boolValue==0) {
                            [activityImageView removeFromSuperview];
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            
                            [alert show];
                        }else if (boolValue==1){
                            NSArray *userArray = [userDict objectForKey:@"message"];
                            NSDictionary *activityData=[userArray objectAtIndex:0];
                            
                            LoginVO *loginvo=[[LoginVO alloc]init];
                            loginvo.user_id=[[NSString alloc]init];
                            loginvo.first_name=[[NSString alloc]init];
                            loginvo.last_name=[[NSString alloc]init];
                            loginvo.email=[[NSString alloc]init];
                            loginvo.mobile=[[NSString alloc]init];
//                            loginvo.gender=[[NSString alloc]init];
                            loginvo.address1=[[NSString alloc]init];
//                            loginvo.address2=[[NSString alloc]init];
                            loginvo.state=[[NSString alloc]init];
                            loginvo.city=[[NSString alloc]init];
                            loginvo.zipcode=[[NSString alloc]init];
//                            loginvo.dob=[[NSString alloc]init];
//                            loginvo.martial_status=[[NSString alloc]init];
                            loginvo.profile_picture=[[NSString alloc]init];
                            loginvo.pwd_changed=[[NSString alloc]init];
                            loginvo.registered=[[NSString alloc]init];
                            loginvo.deleted=[[NSString alloc]init];
                            loginvo.job_title=[[NSString alloc]init];

                            if ([activityData objectForKey:@"user_id"] != [NSNull null])
                                loginvo.user_id=[activityData objectForKey:@"user_id"];
                            
                            if ([activityData objectForKey:@"first_name"] != [NSNull null])
                                loginvo.first_name=[activityData objectForKey:@"first_name"];
                            
                            if ([activityData objectForKey:@"last_name"] != [NSNull null])
                                loginvo.last_name=[activityData objectForKey:@"last_name"];
                            
                            if ([activityData objectForKey:@"email"] != [NSNull null])
                                loginvo.email=[activityData objectForKey:@"email"];
                            
                            if ([activityData objectForKey:@"mobile"] != [NSNull null])
                                loginvo.mobile=[activityData objectForKey:@"mobile"];
                            
//                            if ([activityData objectForKey:@"gender"] != [NSNull null])
//                                loginvo.gender=[activityData objectForKey:@"gender"];
                            
                            if ([activityData objectForKey:@"address"] != [NSNull null])
                                loginvo.address1=[activityData objectForKey:@"address"];
                            
//                            if ([activityData objectForKey:@"address2"] != [NSNull null])
//                                loginvo.address2=[activityData objectForKey:@"address2"];
                            
                            if ([activityData objectForKey:@"state"] != [NSNull null])
                                loginvo.state=[activityData objectForKey:@"state"];
                            
                            if ([activityData objectForKey:@"city"] != [NSNull null])
                                loginvo.city=[activityData objectForKey:@"city"];

                            if ([activityData objectForKey:@"zipcode"] != [NSNull null])
                                loginvo.zipcode=[activityData objectForKey:@"zipcode"];

//                            if ([activityData objectForKey:@"dob"] != [NSNull null])
//                                loginvo.dob=[activityData objectForKey:@"dob"];

//                            if ([activityData objectForKey:@"martial_status"] != [NSNull null])
//                                loginvo.martial_status=[activityData objectForKey:@"martial_status"];

                            if ([activityData objectForKey:@"profile_picture"] != [NSNull null])
                                loginvo.profile_picture=[activityData objectForKey:@"profile_picture"];

                            if ([activityData objectForKey:@"pwd_changed"] != [NSNull null])
                                loginvo.pwd_changed=[activityData objectForKey:@"pwd_changed"];

                            if ([activityData objectForKey:@"registered"] != [NSNull null])
                                loginvo.registered=[activityData objectForKey:@"registered"];

                            if ([activityData objectForKey:@"deleted"] != [NSNull null])
                                loginvo.deleted=[activityData objectForKey:@"deleted"];

                            if ([activityData objectForKey:@"job_title"] != [NSNull null])
                                loginvo.job_title=[activityData objectForKey:@"job_title"];

                            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                            [prefs setObject:loginvo.user_id forKey:@"user_id"];
                            [prefs setObject:loginvo.first_name forKey:@"first_name"];
                            [prefs setObject:loginvo.last_name forKey:@"last_name"];
                            [prefs setObject:loginvo.email forKey:@"email"];
                            [prefs setObject:loginvo.mobile forKey:@"mobile"];
                            [prefs setObject:loginvo.dob forKey:@"dob"];
                            [prefs setObject:loginvo.address1 forKey:@"workaddress"];
                            [prefs setObject:loginvo.state forKey:@"state"];
                            [prefs setObject:loginvo.city forKey:@"city"];
                            [prefs setObject:loginvo.zipcode forKey:@"zipcode"];
                            [prefs setObject:loginvo.job_title forKey:@"jobtitle"];

                            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:loginvo.profile_picture]]];
                            NSData *ImageDatas = UIImageJPEGRepresentation(image,0.1);
                            NSString *imgStr=[[NSString alloc]init];
                            imgStr=  [ImageDatas base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                            NSString *profilekey=[NSString stringWithFormat:@"%@%@",@"profile_picture",[prefs objectForKey:@"user_id"]];
                            [prefs setObject:imgStr forKey:profilekey];

                            [prefs synchronize];
                            
                            if (!loginvo.pwd_changed) {
                                ChangePassViewController *changePass=[[ChangePassViewController alloc] initWithNibName:@"ChangePassViewController" bundle:nil];
                                [self.navigationController pushViewController:changePass animated:YES];
                            }
//                            else if ([loginvo.pwd_changed isEqualToString:@"1"] && [loginvo.registered isEqualToString:@"0"])
//                            {
//                                RegistrationViewController *mainvc=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
//                                [self.navigationController pushViewController:mainvc animated:YES];
//                            }
//                            else if ([loginvo.pwd_changed isEqualToString:@"1"] && [loginvo.registered isEqualToString:@"1"])
                            else{
                                MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                                appDelegate.index=0;
                                [prefs synchronize];
                                [self.navigationController pushViewController:mainvc animated:YES];
                            }
                            [activityImageView removeFromSuperview];
                        }
                    }
                }
            }];
        }
    }
}

-(void)loginWebservices{
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* deviceid = [appDelegate.deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* deviceidsend=[NSString stringWithFormat:@"Iphone%@",deviceid];

    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"email=%@&pwd=%@&device_id=%@",usernameTxt.text,passwordTxt.text,deviceidsend]];
    urlString = [[NSString alloc]initWithFormat:@"%@wsLogin.php",[prefs objectForKey:@"SWACC"]];
    //urlString = [[NSString alloc]initWithFormat:@"https://stg.benefitbridge.com/swacc/api/login?email=%@&pwd=%@&device_id=%@",usernameTxt.text,passwordTxt.text,deviceidsend];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"WE Got %@ :)",dic);
    NSString *result = [[NSString alloc]init];
    result =[dic objectForKey:@"result"];
    NSString *message = [[NSString alloc]init];
    message = [dic objectForKey:@"message"];
    int boolValue =[result intValue];
    if (boolValue==0) {
        [activityImageView removeFromSuperview];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else if (boolValue==1){
        NSArray *userArray = [dic objectForKey:@"message"];
        NSDictionary *activityData=[userArray objectAtIndex:0];
        
        LoginVO *loginvo=[[LoginVO alloc]init];
        loginvo.user_id=[[NSString alloc]init];
        loginvo.first_name=[[NSString alloc]init];
        loginvo.last_name=[[NSString alloc]init];
        loginvo.email=[[NSString alloc]init];
        loginvo.mobile=[[NSString alloc]init];
//        loginvo.gender=[[NSString alloc]init];
        loginvo.address1=[[NSString alloc]init];
//        loginvo.address2=[[NSString alloc]init];
        loginvo.state=[[NSString alloc]init];
        loginvo.city=[[NSString alloc]init];
        loginvo.zipcode=[[NSString alloc]init];
//        loginvo.dob=[[NSString alloc]init];
//        loginvo.martial_status=[[NSString alloc]init];
        loginvo.profile_picture=[[NSString alloc]init];
        loginvo.pwd_changed=[[NSString alloc]init];
        loginvo.registered=[[NSString alloc]init];
        loginvo.deleted=[[NSString alloc]init];
        loginvo.job_title=[[NSString alloc]init];

        if ([activityData objectForKey:@"user_id"] != [NSNull null])
            loginvo.user_id=[activityData objectForKey:@"user_id"];
        
        if ([activityData objectForKey:@"first_name"] != [NSNull null])
            loginvo.first_name=[activityData objectForKey:@"first_name"];
        
        if ([activityData objectForKey:@"last_name"] != [NSNull null])
            loginvo.last_name=[activityData objectForKey:@"last_name"];
        
        if ([activityData objectForKey:@"email"] != [NSNull null])
            loginvo.email=[activityData objectForKey:@"email"];
        
        if ([activityData objectForKey:@"mobile"] != [NSNull null])
            loginvo.mobile=[activityData objectForKey:@"mobile"];
        
//        if ([activityData objectForKey:@"gender"] != [NSNull null])
//            loginvo.gender=[activityData objectForKey:@"gender"];
        
        if ([activityData objectForKey:@"address1"] != [NSNull null])
            loginvo.address1=[activityData objectForKey:@"address1"];
        
//        if ([activityData objectForKey:@"address2"] != [NSNull null])
//            loginvo.address2=[activityData objectForKey:@"address2"];
        
        if ([activityData objectForKey:@"state"] != [NSNull null])
            loginvo.state=[activityData objectForKey:@"state"];
        
        if ([activityData objectForKey:@"city"] != [NSNull null])
            loginvo.city=[activityData objectForKey:@"city"];
        
        if ([activityData objectForKey:@"zipcode"] != [NSNull null])
            loginvo.zipcode=[activityData objectForKey:@"zipcode"];
        
//        if ([activityData objectForKey:@"dob"] != [NSNull null])
//            loginvo.dob=[activityData objectForKey:@"dob"];
//        
//        if ([activityData objectForKey:@"martial_status"] != [NSNull null])
//            loginvo.martial_status=[activityData objectForKey:@"martial_status"];
        
        if ([activityData objectForKey:@"profile_picture"] != [NSNull null])
            loginvo.profile_picture=[activityData objectForKey:@"profile_picture"];
        
        if ([activityData objectForKey:@"pwd_changed"] != [NSNull null])
            loginvo.pwd_changed=[activityData objectForKey:@"pwd_changed"];
        
        if ([activityData objectForKey:@"registered"] != [NSNull null])
            loginvo.registered=[activityData objectForKey:@"registered"];
        
        if ([activityData objectForKey:@"deleted"] != [NSNull null])
            loginvo.deleted=[activityData objectForKey:@"deleted"];
        
        if ([activityData objectForKey:@"job_title"] != [NSNull null])
            loginvo.job_title=[activityData objectForKey:@"job_title"];

        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:loginvo.user_id forKey:@"user_id"];
        [prefs setObject:loginvo.first_name forKey:@"first_name"];
        [prefs setObject:loginvo.last_name forKey:@"last_name"];
        [prefs setObject:loginvo.email forKey:@"email"];
        [prefs setObject:loginvo.mobile forKey:@"mobile"];
        [prefs setObject:loginvo.dob forKey:@"dob"];
        [prefs setObject:loginvo.job_title forKey:@"jobtitle"];
        [prefs setObject:loginvo.address1 forKey:@"workaddress"];
        [prefs setObject:loginvo.state forKey:@"state"];
        [prefs setObject:loginvo.city forKey:@"city"];
        [prefs setObject:loginvo.zipcode forKey:@"zipcode"];

        [prefs synchronize];
        
        if ([loginvo.pwd_changed isEqualToString:@"0"] ) {
            ChangePassViewController *changePass=[[ChangePassViewController alloc] initWithNibName:@"ChangePassViewController" bundle:nil];
            [self.navigationController pushViewController:changePass animated:YES];
        }
//        else if ([loginvo.pwd_changed isEqualToString:@"1"] && [loginvo.registered isEqualToString:@"0"])
//        {
//            RegistrationViewController *mainvc=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
//            [self.navigationController pushViewController:mainvc animated:YES];
//        }
//        else if ([loginvo.pwd_changed isEqualToString:@"1"] && [loginvo.registered isEqualToString:@"1"])
        else{
                MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                appDelegate.index=0;
                [prefs synchronize];
                [self.navigationController pushViewController:mainvc animated:YES];
        }
        [activityImageView removeFromSuperview];
    }
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSArray *obj=[[NSArray alloc]initWithObjects:rest_url, nil];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([obj containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
}
-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust] &&
        ![challenge.protectionSpace.host hasSuffix:@"Login.php"])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

- (void) threadStartAnimating:(id)data {
    UIImage *statusImage = [UIImage imageNamed:@"tmp-0.gif"];
    activityImageView = [[UIImageView alloc]
                         initWithImage:statusImage];
    
    [activityImageView setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
    activityImageView.layer.cornerRadius=8.0f;
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"tmp-0.gif"],
                                         [UIImage imageNamed:@"tmp-1.gif"],
                                         [UIImage imageNamed:@"tmp-2.gif"],
                                         [UIImage imageNamed:@"tmp-3.gif"],
                                         [UIImage imageNamed:@"tmp-4.gif"],
                                         [UIImage imageNamed:@"tmp-5.gif"],
                                         [UIImage imageNamed:@"tmp-6.gif"],
                                         [UIImage imageNamed:@"tmp-7.gif"],
                                         [UIImage imageNamed:@"tmp-8.gif"],
                                         [UIImage imageNamed:@"tmp-9.gif"],
                                         [UIImage imageNamed:@"tmp-10.gif"],
                                         [UIImage imageNamed:@"tmp-11.gif"],
                                         [UIImage imageNamed:@"tmp-12.gif"],
                                         [UIImage imageNamed:@"tmp-13.gif"],
                                         [UIImage imageNamed:@"tmp-14.gif"],
                                         [UIImage imageNamed:@"tmp-15.gif"],
                                         [UIImage imageNamed:@"tmp-16.gif"],
                                         [UIImage imageNamed:@"tmp-17.gif"],
                                         [UIImage imageNamed:@"tmp-18.gif"],
                                         [UIImage imageNamed:@"tmp-19.gif"],
                                         [UIImage imageNamed:@"tmp-20.gif"],
                                         [UIImage imageNamed:@"tmp-21.gif"],
                                         [UIImage imageNamed:@"tmp-22.gif"],
                                         [UIImage imageNamed:@"tmp-23.gif"],
                                         [UIImage imageNamed:@"tmp-24.gif"],
                                         [UIImage imageNamed:@"tmp-25.gif"],
                                         [UIImage imageNamed:@"tmp-26.gif"],
                                         [UIImage imageNamed:@"tmp-27.gif"],
                                         [UIImage imageNamed:@"tmp-28.gif"],
                                         [UIImage imageNamed:@"tmp-29.gif"],
                                         [UIImage imageNamed:@"tmp-30.gif"],
                                         [UIImage imageNamed:@"tmp-31.gif"],
                                         [UIImage imageNamed:@"tmp-32.gif"],
                                         [UIImage imageNamed:@"tmp-33.gif"],
                                         [UIImage imageNamed:@"tmp-34.gif"],
                                         [UIImage imageNamed:@"tmp-35.gif"],
                                         [UIImage imageNamed:@"tmp-36.gif"],
                                         [UIImage imageNamed:@"tmp-37.gif"],
                                         [UIImage imageNamed:@"tmp-38.gif"],
                                         [UIImage imageNamed:@"tmp-39.gif"],
                                         [UIImage imageNamed:@"tmp-40.gif"],
                                         [UIImage imageNamed:@"tmp-41.gif"],
                                         [UIImage imageNamed:@"tmp-42.gif"],
                                         [UIImage imageNamed:@"tmp-43.gif"],
                                         [UIImage imageNamed:@"tmp-44.gif"],
                                         [UIImage imageNamed:@"tmp-45.gif"],
                                         [UIImage imageNamed:@"tmp-46.gif"],
                                         [UIImage imageNamed:@"tmp-47.gif"],
                                         [UIImage imageNamed:@"tmp-48.gif"],
                                         [UIImage imageNamed:@"tmp-49.gif"],
                                         [UIImage imageNamed:@"tmp-50.gif"],
                                         [UIImage imageNamed:@"tmp-51.gif"],
                                         [UIImage imageNamed:@"tmp-52.gif"],
                                         [UIImage imageNamed:@"tmp-53.gif"],
                                         [UIImage imageNamed:@"tmp-54.gif"],
                                         [UIImage imageNamed:@"tmp-55.gif"],
                                         [UIImage imageNamed:@"tmp-56.gif"],
                                         [UIImage imageNamed:@"tmp-57.gif"],
                                         [UIImage imageNamed:@"tmp-58.gif"],
                                         [UIImage imageNamed:@"tmp-59.gif"], nil];
    
    activityImageView.animationDuration = 1.5;
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2
                                         -35,
                                         self.view.frame.size.height/2
                                         -35,70,
                                         70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
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
