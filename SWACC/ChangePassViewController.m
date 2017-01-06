//
//  ChangePassViewController.m
//  SWACC
//
//  Created by Infinitum on 19/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import "ChangePassViewController.h"
#import "UIColor+Expanded.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MainViewController.h"
#import "LoginVO.h"
#import "RegistrationViewController.h"
@interface ChangePassViewController ()

@end

@implementation ChangePassViewController

@synthesize usernameTxt,oldpasswordTxt,newpasswordTxt,confirmPasswordTxt,submitBtn,appDelegate,activityImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text=@"Change password";
    [titleLabel setTextColor: [UIColor whiteColor]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:14.0f];
    titleLabel.font=font1s;
    self.navigationItem.titleView = titleLabel;

    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f9fcf5"]];
    UIView * backgroundview=[[UIView alloc] init];
    [backgroundview setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height*.55)];
    [backgroundview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backgroundview];

    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:14.0f];
    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.15,screenRect.size.width*0.50,55)];
    [logoImg setImage:[UIImage imageNamed:@"HR-Lift_logo.png"]];
    //  [self.view addSubview:logoImg];
    
    //user name text field
    usernameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.18,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    usernameTxt.font=font1;
    usernameTxt.textAlignment=NSTextAlignmentLeft;
    usernameTxt.delegate = self;
    usernameTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    usernameTxt.layer.borderWidth=1.0;
//    usernameTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorders = [CALayer layer];
        bottomBorders.frame = CGRectMake(0.0f, usernameTxt.frame.size.height - 1, usernameTxt.frame.size.width, 1.0f);
        bottomBorders.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [usernameTxt.layer addSublayer:bottomBorders];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    usernameTxt.leftView = paddingView;
    usernameTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * strings = [[NSMutableAttributedString alloc] initWithString:@"User Name*"];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,9)];
    [strings addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9,1)];
    self.usernameTxt.attributedPlaceholder=strings;
    usernameTxt.returnKeyType=UIReturnKeyNext;
    //[self.view addSubview:usernameTxt];
    
    //old password text field
    oldpasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.18,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    oldpasswordTxt.font=font1;
    oldpasswordTxt.textAlignment=NSTextAlignmentLeft;
    oldpasswordTxt.delegate = self;
    oldpasswordTxt.secureTextEntry = YES;
//    oldpasswordTxt.layer.borderWidth=1.0;
//    oldpasswordTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, oldpasswordTxt.frame.size.height - 1, oldpasswordTxt.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [oldpasswordTxt.layer addSublayer:bottomBorder];
    UIView *paddingViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    oldpasswordTxt.leftView = paddingViews;
    oldpasswordTxt.leftViewMode = UITextFieldViewModeAlways;
    oldpasswordTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    NSMutableAttributedString * stringss = [[NSMutableAttributedString alloc] initWithString:@"Current password*"];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,16)];
    [stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(16,1)];
    self.oldpasswordTxt.attributedPlaceholder=stringss;
    oldpasswordTxt.returnKeyType=UIReturnKeyNext;
    [self.view addSubview:oldpasswordTxt];
    
    //new password text field
    newpasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.27,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    newpasswordTxt.font=font1;
    newpasswordTxt.textAlignment=NSTextAlignmentLeft;
    newpasswordTxt.delegate = self;
    newpasswordTxt.secureTextEntry = YES;
//    newpasswordTxt.layer.borderWidth=1.0;
//    newpasswordTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorderss = [CALayer layer];
        bottomBorderss.frame = CGRectMake(0.0f, newpasswordTxt.frame.size.height - 1, newpasswordTxt.frame.size.width, 1.0f);
        bottomBorderss.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [newpasswordTxt.layer addSublayer:bottomBorderss];
    UIView *paddingViewsss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    newpasswordTxt.leftView = paddingViewsss;
    newpasswordTxt.leftViewMode = UITextFieldViewModeAlways;
    newpasswordTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"New password*"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,12)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12,1)];
    self.newpasswordTxt.attributedPlaceholder=string;
    newpasswordTxt.returnKeyType=UIReturnKeyNext;
    [self.view addSubview:newpasswordTxt];
    
    //confirm password text field
    confirmPasswordTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,screenRect.size.height*0.36,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    confirmPasswordTxt.font=font1;
    confirmPasswordTxt.textAlignment=NSTextAlignmentLeft;
    confirmPasswordTxt.delegate = self;
    confirmPasswordTxt.secureTextEntry = YES;
//    confirmPasswordTxt.layer.borderWidth=1.0;
//    confirmPasswordTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBord = [CALayer layer];
        bottomBord.frame = CGRectMake(0.0f, confirmPasswordTxt.frame.size.height - 1, confirmPasswordTxt.frame.size.width, 1.0f);
        bottomBord.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [confirmPasswordTxt.layer addSublayer:bottomBord];
    UIView *paddingVie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    confirmPasswordTxt.leftView = paddingVie;
    confirmPasswordTxt.leftViewMode = UITextFieldViewModeAlways;
    confirmPasswordTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    NSMutableAttributedString * string1 = [[NSMutableAttributedString alloc] initWithString:@"Confirm password*"];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,16)];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(16,1)];
    self.confirmPasswordTxt.attributedPlaceholder=string1;
    confirmPasswordTxt.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:confirmPasswordTxt];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.035];
    
    //submit button
    submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.56,screenRect.size.height*0.45,screenRect.size.width*0.39,screenRect.size.height*0.05)];
    submitBtn.layer.cornerRadius = 6.0f;
    [submitBtn setTitle:@"Update" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"03687f"]];
    [submitBtn.titleLabel setFont:customFontdregs];
    [submitBtn addTarget:self action:@selector(LoginGoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}
-(void)LoginGoBtnClick{
//    RegistrationViewController *mainvc=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
//    [self.navigationController pushViewController:mainvc animated:YES];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    [self performSelector:@selector(LoginGoBtnClicks) withObject:nil afterDelay:1.0 ];
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
    }
    else{
        if ([confirmPasswordTxt.text isEqualToString:@""] && [newpasswordTxt.text isEqualToString:@""] && [oldpasswordTxt.text isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"All fields are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityImageView removeFromSuperview];
            //[oldpasswordTxt becomeFirstResponder];
        }
        else if([confirmPasswordTxt.text isEqualToString:@""]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Confirm password fields is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityImageView removeFromSuperview];
            //[confirmPasswordTxt becomeFirstResponder];
        }
        else if([newpasswordTxt.text isEqualToString:@""]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"New password fields is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityImageView removeFromSuperview];
            //[newpasswordTxt becomeFirstResponder];
        }
        else if(![confirmPasswordTxt.text isEqualToString:newpasswordTxt.text]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"New password and confirm password not same" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityImageView removeFromSuperview];
        }
        else if([oldpasswordTxt.text isEqualToString:newpasswordTxt.text]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Current password and new password is same" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [activityImageView removeFromSuperview];
        }
        else
        {
            if(![self isValidPassword:newpasswordTxt.text]) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Password must be minimum 8 characters, at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [activityImageView removeFromSuperview];
            }
            else{
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                NSString *urlString=[prefs objectForKey:@"SWACC"];
                if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
                    [self performSelector:@selector(loginWebservices) withObject:nil afterDelay:1.0 ];
                }
                else{
                NSURL *url;
                NSMutableString *httpBodyString;
                NSString *urlString;
                NSMutableURLRequest *urlRequest;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&pwd=%@&old_pwd=%@",[prefs objectForKey:@"user_id"],newpasswordTxt.text,oldpasswordTxt.text]];
                    NSString *urlString1=[prefs objectForKey:@"SWACC"];
                    if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
                        urlString = [[NSString alloc]initWithFormat:@"%@wsChangePassword.php",[prefs objectForKey:@"SWACC"]];
                        url=[[NSURL alloc] initWithString:urlString];
                        urlRequest=[NSMutableURLRequest requestWithURL:url];
                        [urlRequest setHTTPMethod:@"POST"];
                        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
                        
                    }else{
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setValue:[prefs objectForKey:@"user_id"] forKey:@"user_id"];
                        [dict setValue:newpasswordTxt.text forKey:@"pwd"];
                        [dict setValue:oldpasswordTxt.text forKey:@"old_pwd"];
                        //convert object to data
                        NSError *error;
                        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
                        
                        urlRequest = [[NSMutableURLRequest alloc] init];
                        [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/changePassword"]];
                        [urlRequest setHTTPMethod:@"POST"];
                        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                        [urlRequest setHTTPBody:jsonData];
                    }

                [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    // your data or an error will be ready here
                    if (error)
                    {
                        [activityImageView removeFromSuperview];
                        NSLog(@"Failed to submit request");
                    }
                    else
                    {
                        [activityImageView removeFromSuperview];
                        NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                                      length:[data length] encoding: NSUTF8StringEncoding];
                        
                        NSError *error;
                        if ([content isEqualToString:@""]) {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            
                            [alert show];
                            [activityImageView removeFromSuperview];
                            
                        }
                        else{
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSString *result = [[NSString alloc]init];
                   result =[userDict objectForKey:@"result"];
                    NSString *message = [[NSString alloc]init];
                     message = [userDict objectForKey:@"message"];
                                int boolValue = [result intValue];
                         if (boolValue==0) {
                                 UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid current password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            
                                        [alert show];
                             [activityImageView removeFromSuperview];
                            
                         }
                         else if (boolValue==1){
                             [prefs setObject:result forKey:@"ChangePassword"];

                             [activityImageView removeFromSuperview];
                             MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
                             appDelegate.index=0;
                             [self.navigationController pushViewController:mainvc animated:YES];
                                }
                            }
                        }
                    }];
                }
            }
        }
    }
}

-(void)loginWebservices{
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&pwd=%@&old_pwd=%@",[prefs objectForKey:@"user_id"],newpasswordTxt.text,oldpasswordTxt.text]];
    
    urlString = [[NSString alloc]initWithFormat:@"%@wsChangePassword.php",[prefs objectForKey:@"SWACC"]];
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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"WE Got %@ :)",dic);
    NSString *result = [[NSString alloc]init];
    result =[dic objectForKey:@"result"];
    NSString *message = [[NSString alloc]init];
    message = [dic objectForKey:@"message"];
    int boolValue = [result intValue];
    if (boolValue==0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid current password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        [activityImageView removeFromSuperview];
        
    }else if (boolValue==1){
        [prefs setObject:result forKey:@"ChangePassword"];
        [activityImageView removeFromSuperview];
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=0;
        [self.navigationController pushViewController:mainvc animated:YES];
    }
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
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
        // accept the certificate anyway
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

- (void) threadStartAnimating:(id)data {
    UIImage *statusImage = [UIImage imageNamed:@"tmp-0.gif"];
    activityImageView = [[UIImageView alloc]initWithImage:statusImage];
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
    activityImageView.frame = CGRectMake(self.view.frame.size.width/2-35,self.view.frame.size.height/2-35,70,70);
    [activityImageView startAnimating];
    [self.view addSubview:activityImageView];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==usernameTxt){
        [oldpasswordTxt becomeFirstResponder];
    }else if(textField==oldpasswordTxt){
        [newpasswordTxt becomeFirstResponder];
    }else if(textField==newpasswordTxt){
        [confirmPasswordTxt becomeFirstResponder];
    }else if(textField==confirmPasswordTxt){
        [confirmPasswordTxt resignFirstResponder];
    }
    return YES;
}

-(BOOL)isValidPassword:(NSString *)passwordString
{
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:passwordString];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==newpasswordTxt) {
        if([textField.text length] >= 8)
        {
            if([self isValidPassword:newpasswordTxt.text]) {
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [newpasswordTxt becomeFirstResponder];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Please Enter at least 8 password"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [newpasswordTxt becomeFirstResponder];
        }
    }
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
