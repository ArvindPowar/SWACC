//
//  ProfileViewController.m
//  Census
//
//  Created by Infinitum on 25/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import "ProfileViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Reachability.h"
#import "UIColor+Expanded.h"
#import "MainViewController.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize firstnameLbl,lastnameLbl,emailLbl,firstnameTxt,lastnameTxt,emailtxt,fingerLogin,appDelegate,offlineSwitch,activityImageView,tokenStr,idcardsYes;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Settings";
    [titleLabel setTextColor: [UIColor whiteColor]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame:CGRectMake(0, 0,30,30)];
    //[leftBtn setTitle:@"< Back" forState:UIControlStateNormal];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIFont * font =[UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    [leftBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_white.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.titleLabel.font = font;
    [leftBtn setTintColor:[self colorFromHexString:@"#03687f"]];
    
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];
    
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    UIFont * fontss =[UIFont fontWithName:@"OpenSans-Bold" size:15.0f];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    UIImageView *bannerAsyncimg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*.30, screenRect.size.height*.13, screenRect.size.width*.40, screenRect.size.height*.07)];
    [bannerAsyncimg.layer setMasksToBounds:YES];
    bannerAsyncimg.clipsToBounds=YES;
    [bannerAsyncimg setBackgroundColor:[UIColor clearColor]];
    NSData *receivedData = (NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"clientlogo"];
    UIImage *image = [[UIImage alloc] initWithData:receivedData];
    bannerAsyncimg.image=image;
    [self.view addSubview:bannerAsyncimg];
    
    UIImageView * whiteback=[[UIImageView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.81,screenRect.size.width,screenRect.size.height*0.12)];
    [whiteback setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview:whiteback];
    
    UIImageView * logoImg=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.25,screenRect.size.height*0.92,screenRect.size.width*0.50,screenRect.size.height*0.06)];
    [logoImg setImage:[UIImage imageNamed:@"HR-Lift_logo.png"]];
    //[self.view addSubview:logoImg];
    
    firstnameLbl = [[UILabel alloc] init];
    [firstnameLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.25, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    firstnameLbl.textAlignment = NSTextAlignmentLeft;
    firstnameLbl.text=@"First Name";
    [firstnameLbl setTextColor: [UIColor blackColor]];
    firstnameLbl.font=fontss;
    [self.view addSubview:firstnameLbl];
    
    firstnameTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.31, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    firstnameTxt.delegate = self;
    firstnameTxt.textAlignment=NSTextAlignmentLeft;
    firstnameTxt.textColor=[UIColor blackColor];
    [firstnameTxt setBackgroundColor:[UIColor clearColor]];
    self.firstnameTxt.font = fonts;
    //    [[firstnameTxt layer] setBorderWidth:1.0f];
    //    [[firstnameTxt layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    //    firstnameTxt.layer.cornerRadius=8.0f;
    //    UIView *paddingViewssss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    //    firstnameTxt.leftView = paddingViewssss;
    //    firstnameTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIColor *color = [UIColor grayColor];
    color = [color colorWithAlphaComponent:1.0f];
    self.firstnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:firstnameTxt];
    
    lastnameLbl = [[UILabel alloc] init];
    [lastnameLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.37, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    lastnameLbl.textAlignment = NSTextAlignmentLeft;
    lastnameLbl.text=@"Last Name";
    [lastnameLbl setTextColor: [UIColor blackColor]];
    lastnameLbl.font=fontss;
    [self.view addSubview:lastnameLbl];
    
    
    lastnameTxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.43, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    lastnameTxt.delegate = self;
    lastnameTxt.textAlignment=NSTextAlignmentLeft;
    lastnameTxt.textColor=[UIColor blackColor];
    [lastnameTxt setBackgroundColor:[UIColor clearColor]];
    self.lastnameTxt.font = fonts;
    //    [[lastnameTxt layer] setBorderWidth:1.0f];
    //    [[lastnameTxt layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    //    lastnameTxt.layer.cornerRadius=8.0f;
    //    UIView *paddingViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    //    lastnameTxt.leftView = paddingViews;
    //    lastnameTxt.leftViewMode = UITextFieldViewModeAlways;
    color = [color colorWithAlphaComponent:1.0f];
    self.lastnameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:lastnameTxt];
    
    emailLbl = [[UILabel alloc] init];
    [emailLbl setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.49, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    emailLbl.textAlignment = NSTextAlignmentLeft;
    emailLbl.text=@"Email";
    [emailLbl setTextColor: [UIColor blackColor]];
    emailLbl.font=fontss;
    [self.view addSubview:emailLbl];
    
    emailtxt=[[UITextField alloc]initWithFrame:CGRectMake(screenRect.size.width*0.10,screenRect.size.height*0.55, screenRect.size.width*0.80, screenRect.size.height*0.05)];
    emailtxt.delegate = self;
    emailtxt.textAlignment=NSTextAlignmentLeft;
    emailtxt.textColor=[UIColor blackColor];
    [emailtxt setBackgroundColor:[UIColor clearColor]];
    self.emailtxt.font = fonts;
    //    [[emailtxt layer] setBorderWidth:1.0f];
    //    [[emailtxt layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    //    emailtxt.layer.cornerRadius=8.0f;
    //    UIView *paddingViewsss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    //    emailtxt.leftView = paddingViewsss;
    //    emailtxt.leftViewMode = UITextFieldViewModeAlways;
    color = [color colorWithAlphaComponent:1.0f];
    self.emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:emailtxt];
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        UILabel * fingerToLogin = [[UILabel alloc] init];
        [fingerToLogin setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.63, screenRect.size.width*0.60, screenRect.size.height*0.05)];
        fingerToLogin.textAlignment = NSTextAlignmentLeft;
        fingerToLogin.text=@"Touch ID Sign-In";
        [fingerToLogin setTextColor: [UIColor blackColor]];
        fingerToLogin.font=fontss;
        [self.view addSubview:fingerToLogin];
        
        fingerLogin =[[UISwitch alloc]init];
        NSString *strlo=[prefs objectForKey:@"FingerLogin"];
        if ([strlo isEqualToString:@"YES"] && strlo !=nil){
            fingerLogin.on=YES;
        }
        else{
            fingerLogin.on=NO;
        }
        NSString *modes=[prefs objectForKey:@"modes"];
        if ([modes isEqualToString:@"offline"]) {
            
            fingerLogin.userInteractionEnabled = NO;
            
        }else{
            fingerLogin.userInteractionEnabled = YES;
        }
        
        [fingerLogin.layer setFrame:CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.63,screenRect.size.width*0.20,40)];
        [fingerLogin addTarget:self action:@selector(lockappOnOff) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:fingerLogin];
    }
    
//    UILabel * fingerToLogin = [[UILabel alloc] init];
//    [fingerToLogin setFrame:CGRectMake(screenRect.size.width*0.10, screenRect.size.height*0.73, screenRect.size.width*0.60, screenRect.size.height*0.05)];
//    fingerToLogin.textAlignment = NSTextAlignmentLeft;
//    fingerToLogin.text=@"Offline mode";
//    [fingerToLogin setTextColor: [UIColor blackColor]];
//    fingerToLogin.font=fontss;
//    [self.view addSubview:fingerToLogin];
//
//    offlineSwitch=[[UISwitch alloc]init];
//    [offlineSwitch.layer setFrame:CGRectMake(screenRect.size.width*0.70,screenRect.size.height*0.73,screenRect.size.width*0.20,40)];
//    [offlineSwitch addTarget:self action:@selector(OnOfflineMode) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:offlineSwitch];
//    NSString *modes=[prefs objectForKey:@"modes"];
//    if ([modes isEqualToString:@"offline"]) {
//        offlineSwitch.userInteractionEnabled = NO;
//    }else{
//        offlineSwitch.userInteractionEnabled = YES;
//    }
//    NSString *mode=[prefs objectForKey:@"mode"];
//    if ([mode isEqualToString:@"offline"]) {
//        offlineSwitch.on=YES;
//    }else{
//        offlineSwitch.on=NO;
//    }

    firstnameTxt.text=[prefs objectForKey:@"first_name"];
    lastnameTxt.text=[prefs objectForKey:@"last_name"];
    emailtxt.text=[prefs objectForKey:@"email"];
    
    firstnameTxt.enabled = NO;
    lastnameTxt.enabled = NO;
    emailtxt.enabled = NO;
}
-(IBAction)OnOfflineMode{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(offlineSwitch.on == YES)
    {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BenefitBridge" message:@"This may take a few moments" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
//        [alert show];
//    }else{
//        [prefs setObject:@"online" forKey:@"mode"];
//        //appDelegate.offline=NO;
    }
    [prefs synchronize];
}

-(IBAction)lockappOnOff{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(fingerLogin.on == YES)
    {
        [prefs setObject:@"YES" forKey:@"FingerLogin"];
    }else{
        [prefs setObject:@"NO" forKey:@"FingerLogin"];
    }
    [prefs synchronize];
}
-(void)BackAction{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
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
