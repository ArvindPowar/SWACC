//
//  RegistrationViewController.m
//  SWACC
//
//  Created by Infinitum on 19/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import "RegistrationViewController.h"
#import "UIColor+Expanded.h"
#import "CityVO.h"
#import "StateVO.h"
#import "MaritalStatusVO.h"
#import "Reachability.h"
#import "MainViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#define MAX_LENGTH 5

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize appDelegate,firstNameTxt,lastNameTxt,genderTxt,dateofBirthTxt,maritalstatusTxt,PhonenoTxt,emailTxt,address1Txt,address2Txt,cityTxt,stateTxt,zipTxt,DriverLecIDTxt,DriverLecIDExpirydateTxt,DriverLecIDissuingstateTxt,firstnameLbl,lastnameLbl,genderLbl,dateofBirthLbl,maritalstatusLbl,phonenoLbl,emailLbl,address1Lbl,address2Lbl,cityLbl,stateLbl,zipLbl,DriverLecIDLbl,DriverLecIDExpirydateLbl,DriverLecIDissuingstateLbl,scrollView,datePicker,dateToobar,phoneToolbar,zipToolbar,genderArray,maritalArray,stateArray,genderpickerview,maritalpickerview,statepickerview,toolbargender,toolbarmarital,toolbarstate,stateStr,maritalStr,genderStr,datePickerdriverexpDate,datedriverexpToolbar,genderMaleBtn,genderfemaleBtn,exemptBtn,nonexemptBtn,signimgBtn,updateBtn,clearsignBtn,cityPickerview,drivingPickerview,cityToolbar,driverToolbar,cityStr,activityImageView,
stateid,cityid,genderId,maritalId,iscityPicker,cityArray,commonUrl,photoImageview,profilealertView,profileimgByteStr,jobtitleTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#851c2b"];
    self.navigationItem.hidesBackButton = YES;
    appDelegate=[[UIApplication sharedApplication] delegate];
    commonUrl=[[NSString alloc]init];
     UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"My Profile";
    [titleLabel setTextColor: [UIColor whiteColor]];
    UIFont * font1s =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1s;
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
    [leftBtn setTintColor:[UIColor colorWithHexString:@"#03687f"]];
    [self.navigationItem setLeftBarButtonItems:@[btn] animated:NO];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIColor *color = [UIColor colorWithHexString:@"abacac"];
    color = [color colorWithAlphaComponent:1.0f];
    UIFont * font1 =[UIFont fontWithName:@"Open Sans" size:15.0f];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    
    UIFont *customFontdregs = [UIFont fontWithName:@"OpenSans-Bold" size:screenRect.size.width*0.035];
    
    UILabel *titleLabelname = [[UILabel alloc] init];
    [titleLabelname setFrame:CGRectMake(screenRect.size.width*0.05, screenRect.size.height*0.125, screenRect.size.width*0.90, 25)];
    titleLabelname.textAlignment = NSTextAlignmentCenter;
    titleLabelname.text=@"Personal Information";
    [titleLabelname setTextColor: [UIColor colorWithHexString:@"#03687f"]];
    titleLabelname.font=font1s;
    //[self.view addSubview:titleLabelname];
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*.11, screenRect.size.width, screenRect.size.height*0.89)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    
    //iscityPicker=false;
    int heigth=0;
    
    photoImageview=[[UIImageView alloc]initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.25,screenRect.size.width*0.25)];
    photoImageview.layer.borderWidth=1.0f;
    photoImageview.layer.borderColor=[UIColor blueColor].CGColor;
    photoImageview.layer.cornerRadius=20.0f;
    [photoImageview setBackgroundColor:[UIColor clearColor]];
    self.photoImageview.clipsToBounds = YES;
    [scrollView addSubview:self.photoImageview];
    
    updateBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.40,screenRect.size.width*0.10,screenRect.size.width*0.39,screenRect.size.height*0.05)];
    updateBtn.layer.cornerRadius = 6.0f;
    [updateBtn setTitle:@"Update picture" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[goBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [updateBtn setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    [updateBtn.titleLabel setFont:customFontdregs];
    [updateBtn addTarget:self action:@selector(PhotoImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:updateBtn];
    
    heigth=heigth+screenRect.size.height*0.20;
    
    firstNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    firstNameTxt.font=font1;
    firstNameTxt.textAlignment=NSTextAlignmentLeft;
    firstNameTxt.delegate = self;
    firstNameTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    firstNameTxt.layer.borderWidth=1.0;
//    firstNameTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorders = [CALayer layer];
        bottomBorders.frame = CGRectMake(0.0f, firstNameTxt.frame.size.height - 1, firstNameTxt.frame.size.width, 1.0f);
        bottomBorders.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [firstNameTxt.layer addSublayer:bottomBorders];
    UIView *paddingViewsb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    firstNameTxt.leftView = paddingViewsb;
    firstNameTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"First Name"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,10)];
    // [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
    self.firstNameTxt.attributedPlaceholder=string;
    [scrollView addSubview:firstNameTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    lastNameTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    lastNameTxt.font=font1;
    lastNameTxt.textAlignment=NSTextAlignmentLeft;
    lastNameTxt.delegate = self;
    lastNameTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    lastNameTxt.layer.borderWidth=1.0;
//    lastNameTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorders1 = [CALayer layer];
        bottomBorders1.frame = CGRectMake(0.0f, lastNameTxt.frame.size.height - 1, lastNameTxt.frame.size.width, 1.0f);
        bottomBorders1.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [lastNameTxt.layer addSublayer:bottomBorders1];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    lastNameTxt.leftView = paddingView1;
    lastNameTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string1 = [[NSMutableAttributedString alloc] initWithString:@"Last Name"];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,9)];
    //[string1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9,1)];
    self.lastNameTxt.attributedPlaceholder=string1;
    [scrollView addSubview:lastNameTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    emailTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    emailTxt.font=font1;
    emailTxt.textAlignment=NSTextAlignmentLeft;
    emailTxt.delegate = self;
    emailTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    emailTxt.layer.borderWidth=1.0;
//    emailTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorder7 = [CALayer layer];
        bottomBorder7.frame = CGRectMake(0.0f, emailTxt.frame.size.height - 1, emailTxt.frame.size.width, 1.0f);
        bottomBorder7.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [emailTxt.layer addSublayer:bottomBorder7];
    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    emailTxt.leftView = paddingView7;
    emailTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string11 = [[NSMutableAttributedString alloc] initWithString:@"Email"];
    [string11 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,5)];
    //[string5 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13,1)];
    self.emailTxt.attributedPlaceholder=string11;
    [scrollView addSubview:emailTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    PhonenoTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    PhonenoTxt.font=font1;
    PhonenoTxt.textAlignment=NSTextAlignmentLeft;
    PhonenoTxt.delegate = self;
    PhonenoTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    PhonenoTxt.layer.borderWidth=1.0;
//    PhonenoTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorders8 = [CALayer layer];
        bottomBorders8.frame = CGRectMake(0.0f, PhonenoTxt.frame.size.height - 1, PhonenoTxt.frame.size.width, 1.0f);
        bottomBorders8.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [PhonenoTxt.layer addSublayer:bottomBorders8];
    UIView *paddingViewr = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    PhonenoTxt.leftView = paddingViewr;
    PhonenoTxt.tag=2;
    [PhonenoTxt setTintColor:[UIColor lightGrayColor]];
    PhonenoTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string10 = [[NSMutableAttributedString alloc] initWithString:@"Phone Number*"];
    [string10 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,12)];
    [string10 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12,1)];
    self.PhonenoTxt.attributedPlaceholder=string10;
    [PhonenoTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    phoneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    phoneToolbar.barStyle = UIBarStyleBlackOpaque;
    [phoneToolbar setBarStyle:UIBarStyleBlackOpaque];
    
    phoneToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [phoneToolbar sizeToFit];
    phoneToolbar.tintColor=[UIColor whiteColor];
    PhonenoTxt.inputAccessoryView = phoneToolbar;
    PhonenoTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:PhonenoTxt];
    
    //heigth=heigth+screenRect.size.height*0.08;
    

//    UIView * broderview=[[UIView alloc] init];
//    [broderview setFrame:CGRectMake(screenRect.size.width*0.05, heigth, screenRect.size.width*0.445, screenRect.size.height*0.06)];
//    broderview.layer.borderWidth=1.0;
//    broderview.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
//    [broderview setBackgroundColor:[UIColor clearColor]];
//    [scrollView addSubview:broderview];
    
//    UILabel *genderLbls= [[UILabel alloc] init];
//    [genderLbls setFrame:CGRectMake(screenRect.size.width*0.06,heigth, screenRect.size.width*0.20, screenRect.size.height*0.05)];
//    genderLbls.textAlignment = NSTextAlignmentLeft;
//    NSMutableAttributedString * stringfemales = [[NSMutableAttributedString alloc] initWithString:@" Gender"];
//    [stringfemales addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"abacac"] range:NSMakeRange(0,7)];
//    //[stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
//    genderLbls.attributedText=stringfemales;
//    genderLbls.font=fonts;
//    [scrollView addSubview:genderLbls];
//
//    genderMaleBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.27, heigth,screenRect.size.height*0.05,screenRect.size.height*0.05)];
//    [genderMaleBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
//    [genderMaleBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
//    genderMaleBtn.layer.cornerRadius = 6.0f;
//    [genderMaleBtn setTag:1];
//    //[ownsettingBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
//    [genderMaleBtn addTarget:self action:@selector(genderAction:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:genderMaleBtn];
//    
//    
//    UILabel *maleLbl1= [[UILabel alloc] init];
//    [maleLbl1 setFrame:CGRectMake(screenRect.size.width*0.37,heigth, screenRect.size.width*0.30, screenRect.size.height*0.05)];
//    maleLbl1.textAlignment = NSTextAlignmentLeft;
//    NSMutableAttributedString * stringmale = [[NSMutableAttributedString alloc] initWithString:@"Male"];
//    [stringmale addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
//    //[stringss1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
//    maleLbl1.attributedText=stringmale;
//    maleLbl1.font=fonts;
//    [scrollView addSubview:maleLbl1];
//    
////    UIView * broderview1=[[UIView alloc] init];
////    [broderview1 setFrame:CGRectMake(screenRect.size.width*0.505, heigth, screenRect.size.width*0.45, screenRect.size.height*0.06)];
////    broderview1.layer.borderWidth=1.0;
////    broderview1.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
////    [broderview1 setBackgroundColor:[UIColor clearColor]];
////    [scrollView addSubview:broderview1];
//    
//    genderfemaleBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.605, heigth,screenRect.size.height*0.05,screenRect.size.height*0.05)];
//    [genderfemaleBtn setBackgroundImage:[UIImage imageNamed:@"Offswitch.png"] forState:UIControlStateNormal];
//    [genderfemaleBtn setBackgroundImage:[UIImage imageNamed:@"Onswitch.png"] forState:UIControlStateSelected];
//    genderfemaleBtn.layer.cornerRadius = 6.0f;
//    [genderfemaleBtn setTag:2];
//    //[ownsettingBtn setBackgroundColor:[UIColor colorWithHexString:@"4a89dc"]];
//    [genderfemaleBtn addTarget:self action:@selector(genderAction:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:genderfemaleBtn];
//    
//    UILabel *femaleLbl2= [[UILabel alloc] init];
//    [femaleLbl2 setFrame:CGRectMake(screenRect.size.width*0.70,heigth, screenRect.size.width*0.38, screenRect.size.height*0.05)];
//    femaleLbl2.textAlignment = NSTextAlignmentLeft;
//    NSMutableAttributedString * stringfemale = [[NSMutableAttributedString alloc] initWithString:@"Female"];
//    [stringfemale addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,6)];
//    //[stringss addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,1)];
//    femaleLbl2.attributedText=stringfemale;
//    femaleLbl2.font=fonts;
//    [scrollView addSubview:femaleLbl2];
//    
//    heigth=heigth+screenRect.size.height*0.055;
//
//        UIView * lineview=[[UIView alloc] init];
//        [lineview setFrame:CGRectMake(screenRect.size.width*0.05, heigth, screenRect.size.width*0.90, 1)];
//        [lineview setBackgroundColor:[UIColor colorWithHexString:@"ebeded"]];
//        [scrollView addSubview:lineview];
//
//    [genderMaleBtn setSelected:YES];
//    genderStr=@"Male";
    
//    heigth=heigth+screenRect.size.height*0.03;
//    
//    dateofBirthTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
//    dateofBirthTxt.font=font1;
//    dateofBirthTxt.textAlignment=NSTextAlignmentLeft;
//    dateofBirthTxt.delegate = self;
//    dateofBirthTxt.textColor=[UIColor colorWithHexString:@"#32333"];
////    dateofBirthTxt.layer.borderWidth=1.0;
////    dateofBirthTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
//    CALayer *bottomBorder4 = [CALayer layer];
//    bottomBorder4.frame = CGRectMake(0.0f, dateofBirthTxt.frame.size.height - 1, dateofBirthTxt.frame.size.width, 1.0f);
//    bottomBorder4.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
//    [dateofBirthTxt.layer addSublayer:bottomBorder4];
//    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    dateofBirthTxt.leftView = paddingView4;
//    dateofBirthTxt.leftViewMode = UITextFieldViewModeAlways;
//    NSMutableAttributedString * string5 = [[NSMutableAttributedString alloc] initWithString:@"Date of Birth*"];
//    [string5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,13)];
//    [string5 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13,1)];
//    self.dateofBirthTxt.attributedPlaceholder=string5;
//    [scrollView addSubview:dateofBirthTxt];
    
//    heigth=heigth+screenRect.size.height*0.08;
//    
//    maritalstatusTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
//    maritalstatusTxt.font=font1;
//    maritalstatusTxt.textAlignment=NSTextAlignmentLeft;
//    maritalstatusTxt.delegate = self;
//    maritalstatusTxt.textColor=[UIColor colorWithHexString:@"#32333"];
////    maritalstatusTxt.layer.borderWidth=1.0;
////    maritalstatusTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
//        CALayer *bottomBorder5 = [CALayer layer];
//        bottomBorder5.frame = CGRectMake(0.0f, maritalstatusTxt.frame.size.height - 1, maritalstatusTxt.frame.size.width, 1.0f);
//        bottomBorder5.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
//        [maritalstatusTxt.layer addSublayer:bottomBorder5];
//    UIView *paddingViews5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    maritalstatusTxt.leftView = paddingViews5;
//    maritalstatusTxt.leftViewMode = UITextFieldViewModeAlways;
//    NSMutableAttributedString * string7 = [[NSMutableAttributedString alloc] initWithString:@"Marital Status*"];
//    [string7 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,14)];
//    [string7 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(14,1)];
//    self.maritalstatusTxt.attributedPlaceholder=string7;
//    [scrollView addSubview:maritalstatusTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    address1Txt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    address1Txt.font=font1;
    address1Txt.textAlignment=NSTextAlignmentLeft;
    address1Txt.delegate = self;
    address1Txt.textColor=[UIColor colorWithHexString:@"#32333"];
//    address1Txt.layer.borderWidth=1.0;
//    address1Txt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
    address1Txt.tag=1;
        CALayer *bottomBorder8 = [CALayer layer];
        bottomBorder8.frame = CGRectMake(0.0f, address1Txt.frame.size.height - 1, address1Txt.frame.size.width, 1.0f);
        bottomBorder8.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [address1Txt.layer addSublayer:bottomBorder8];
    UIView *paddingViews8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    address1Txt.leftView = paddingViews8;
    address1Txt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string14 = [[NSMutableAttributedString alloc] initWithString:@"Work Address*"];
    [string14 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,12)];
    [string14 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12,1)];
    self.address1Txt.attributedPlaceholder=string14;
    [scrollView addSubview:address1Txt];
    
//    heigth=heigth+screenRect.size.height*0.08;
//    
//    address2Txt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
//    address2Txt.font=font1;
//    address2Txt.textAlignment=NSTextAlignmentLeft;
//    address2Txt.delegate = self;
//    address2Txt.textColor=[UIColor colorWithHexString:@"#32333"];
////    address2Txt.layer.borderWidth=1.0;
////    address2Txt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
//    address2Txt.tag=2;
//        CALayer *bottomBorder9 = [CALayer layer];
//        bottomBorder9.frame = CGRectMake(0.0f, address2Txt.frame.size.height - 1, address2Txt.frame.size.width, 1.0f);
//        bottomBorder9.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
//        [address2Txt.layer addSublayer:bottomBorder9];
//    UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
//    address2Txt.leftView = paddingView9;
//    address2Txt.leftViewMode = UITextFieldViewModeAlways;
//    NSMutableAttributedString * string15 = [[NSMutableAttributedString alloc] initWithString:@"Home Address 2"];
//    [string15 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,5)];
//    //[string5 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13,1)];
//    self.address2Txt.attributedPlaceholder=string15;
//    [scrollView addSubview:address2Txt];
    
    heigth=heigth+screenRect.size.height*0.08;
    //
    //    heigth=heigth+screenRect.size.height*0.06;
    stateTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    stateTxt.font=font1;
    stateTxt.textAlignment=NSTextAlignmentLeft;
    stateTxt.delegate = self;
    stateTxt.tag=3;
    stateTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    stateTxt.layer.borderWidth=1.0;
//    stateTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorder11 = [CALayer layer];
        bottomBorder11.frame = CGRectMake(0.0f, stateTxt.frame.size.height - 1, stateTxt.frame.size.width, 1.0f);
        bottomBorder11.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [stateTxt.layer addSublayer:bottomBorder11];
    UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    stateTxt.leftView = paddingView11;
    stateTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string20 = [[NSMutableAttributedString alloc] initWithString:@"State*"];
    [string20 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,5)];
    [string20 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,1)];
    self.stateTxt.attributedPlaceholder=string20;
    [scrollView addSubview:stateTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    cityTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    cityTxt.font=font1;
    cityTxt.textAlignment=NSTextAlignmentLeft;
    cityTxt.delegate = self;
    cityTxt.tag=4;
    cityTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    cityTxt.layer.borderWidth=1.0;
//    cityTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
        CALayer *bottomBorder10 = [CALayer layer];
        bottomBorder10.frame = CGRectMake(0.0f, cityTxt.frame.size.height - 1, cityTxt.frame.size.width, 1.0f);
        bottomBorder10.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [cityTxt.layer addSublayer:bottomBorder10];
    UIView *paddingViews10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    cityTxt.leftView = paddingViews10;
    cityTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string19 = [[NSMutableAttributedString alloc] initWithString:@"City*"];
    [string19 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,4)];
    [string19 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,1)];
    self.cityTxt.attributedPlaceholder=string19;
    [scrollView addSubview:cityTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    zipTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    zipTxt.font=font1;
    zipTxt.textAlignment=NSTextAlignmentLeft;
    zipTxt.delegate = self;
    zipTxt.textColor=[UIColor colorWithHexString:@"#32333"];
//    zipTxt.layer.borderWidth=1.0;
//    zipTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
    zipTxt.tag=5;
        CALayer *bottomBorders7 = [CALayer layer];
        bottomBorders7.frame = CGRectMake(0.0f, zipTxt.frame.size.height - 1, zipTxt.frame.size.width, 1.0f);
        bottomBorders7.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
        [zipTxt.layer addSublayer:bottomBorders7];
    UIView *paddingViewssss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    zipTxt.leftView = paddingViewssss;
    [zipTxt setTintColor:[UIColor lightGrayColor]];
    zipTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * string21 = [[NSMutableAttributedString alloc] initWithString:@"Zip Code*"];
    [string21 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,8)];
    [string21 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8,1)];
    self.zipTxt.attributedPlaceholder=string21;
    [zipTxt setKeyboardType:UIKeyboardTypeDecimalPad];
    zipToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    zipToolbar.barStyle = UIBarStyleBlackOpaque;
    zipToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(doneWithNumberPad)],
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [zipToolbar sizeToFit];
    zipToolbar.tintColor=[UIColor whiteColor];
    zipTxt.inputAccessoryView = zipToolbar;
    zipTxt.returnKeyType=UIReturnKeyNext;
    [scrollView addSubview:zipTxt];
    
    heigth=heigth+screenRect.size.height*0.08;
    
    jobtitleTxt = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width*0.05,heigth,screenRect.size.width*0.90,screenRect.size.height*0.05)];
    jobtitleTxt.font=font1;
    jobtitleTxt.textAlignment=NSTextAlignmentLeft;
    jobtitleTxt.delegate = self;
    jobtitleTxt.tag=6;
    jobtitleTxt.textColor=[UIColor colorWithHexString:@"#32333"];
    //    cityTxt.layer.borderWidth=1.0;
    //    cityTxt.layer.borderColor=[UIColor colorWithHexString:@"#ebeded"].CGColor;
    CALayer *botBorder11 = [CALayer layer];
    botBorder11.frame = CGRectMake(0.0f, jobtitleTxt.frame.size.height - 1, jobtitleTxt.frame.size.width, 1.0f);
    botBorder11.backgroundColor = [UIColor colorWithHexString:@"#ebeded"].CGColor;
    [jobtitleTxt.layer addSublayer:botBorder11];
    UIView *paddingViews11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    jobtitleTxt.leftView = paddingViews11;
    jobtitleTxt.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString * stri = [[NSMutableAttributedString alloc] initWithString:@"Job Title"];
    [stri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#abacac"] range:NSMakeRange(0,9)];
    //[stri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9,1)];
    self.jobtitleTxt.attributedPlaceholder=stri;
    [scrollView addSubview:jobtitleTxt];
    
    heigth=heigth+screenRect.size.height*0.08;

    updateBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.56,heigth,screenRect.size.width*0.39,screenRect.size.height*0.05)];
    updateBtn.layer.cornerRadius = 6.0f;
    [updateBtn setTitle:@"Update" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[goBtn setBackgroundImage:[UIImage imageNamed:@"Button-ayarlar.png"]forState:UIControlStateNormal];
    [updateBtn setBackgroundColor:[UIColor colorWithHexString:@"03687f"]];
    [updateBtn.titleLabel setFont:customFontdregs];
    [updateBtn addTarget:self action:@selector(UpdateAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:updateBtn];
    
    heigth=heigth+screenRect.size.height*0.06;
//
    scrollView.contentSize=CGSizeMake(screenRect.size.width,heigth+20);
//
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *profilekey=[NSString stringWithFormat:@"%@%@",@"profile_picture",[prefs objectForKey:@"user_id"]];
    if ([prefs objectForKey:profilekey]!=nil && ![[prefs objectForKey:profilekey] isEqualToString:@""]) {
        NSData *nsdataBackBase64String = [[NSData alloc] initWithBase64EncodedString:[prefs objectForKey:profilekey] options:0];
        UIImage *img1 = [UIImage imageWithData: nsdataBackBase64String];
        photoImageview.contentMode = UIViewContentModeScaleAspectFit;
        photoImageview.image=img1;
        
    }else{
        [photoImageview setImage:[UIImage imageNamed:@"upload_Picture.png"]];
    }
    

    firstNameTxt.text=[prefs objectForKey:@"first_name"];
    lastNameTxt.text=[prefs objectForKey:@"last_name"];
    PhonenoTxt.text=[prefs objectForKey:@"mobile"];
    emailTxt.text=[prefs objectForKey:@"email"];
    address1Txt.text=[prefs objectForKey:@"workaddress"];
    stateTxt.text=[prefs objectForKey:@"state"];
    cityTxt.text=[prefs objectForKey:@"city"];
    zipTxt.text=[prefs objectForKey:@"zipcode"];
    PhonenoTxt.text=[prefs objectForKey:@"mobile"];
    jobtitleTxt.text=[prefs objectForKey:@"jobtitle"];

    firstNameTxt.enabled=NO;
    lastNameTxt.enabled=NO;
    //PhonenoTxt.enabled=NO;
    emailTxt.enabled=NO;
    jobtitleTxt.enabled=NO;

//    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
//    NSString *urlString=[prefs objectForKey:@"SWACC"];
//    
//    if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
//        [self performSelector:@selector(getStatenames1) withObject:nil afterDelay:1.0 ];
//    }else{
//        
//        [self performSelector:@selector(getStatenames) withObject:nil afterDelay:1.0 ];
//    }

}
- (IBAction)PhotoImageAction:(id)sender
{
    profilealertView = [[CustomIOS7AlertView alloc] init];
    [profilealertView setContainerView:[self profileImageSetAlert]];
    [profilealertView setDelegate:self];
    [profilealertView setUseMotionEffects:true];
    [profilealertView show];
}

-(UIView *)profileImageSetAlert{
    UIView *demoView;
    demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,200)];
    [demoView setBackgroundColor:[UIColor whiteColor]];
    demoView.layer.cornerRadius=5;
    [demoView.layer setMasksToBounds:YES];
    [demoView.layer setBorderWidth:1.0];
    demoView.layer.borderColor=[[UIColor blackColor]CGColor];
    
    UIButton *topButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    [topButton setTitle:@"SWACC" forState:UIControlStateNormal];
    [topButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    topButton.layer.cornerRadius=1.0;
    [topButton setBackgroundColor:[UIColor clearColor]];
    [topButton setFont:[UIFont boldSystemFontOfSize:20]];
    [topButton setTitleColor:[UIColor colorWithHexString:@"03687f"] forState:UIControlStateNormal];
    [demoView addSubview:topButton];
    
    UIButton *galleryOption=[[UIButton alloc] initWithFrame:CGRectMake(0,50, 300,48)];
    [galleryOption setTitle:@"Gallery" forState:UIControlStateNormal];
    [galleryOption addTarget:self
                      action:@selector(galleryOption)
            forControlEvents:UIControlEventTouchUpInside];
    [galleryOption setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    galleryOption.tag=1;
    [galleryOption setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [demoView addSubview:galleryOption];
    
    UIButton *cameraOption=[[UIButton alloc] initWithFrame:CGRectMake(0,100, 300,48)];
    [cameraOption setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraOption addTarget:self
                     action:@selector(cameraOption)
           forControlEvents:UIControlEventTouchUpInside];
    [cameraOption setBackgroundColor:[UIColor colorWithHexString:@"d08c2a"]];
    cameraOption.tag=1;
    [cameraOption setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [demoView addSubview:cameraOption];
    
    UIButton *cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,150,300,50)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(closeAlert:)
        forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundColor:[UIColor clearColor]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [demoView addSubview:cancelBtn];
    return demoView;
}
-(void)BackAction{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];
}


-(void)closeAlert:(id)sender{
    [profilealertView close];
}
-(void)galleryOption{
    [profilealertView close];
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)cameraOption{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Sorry, you do not have a camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        return;
    }
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    [profilealertView close];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = (id)self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
        // [controller release];
    }
    else
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker =
        [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        
        picker.delegate = (id)self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage * chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *img = [UIImage imageNamed:@"home.png"];
            photoImageview.image=chosenImage;
            NSData *imageData = UIImageJPEGRepresentation(chosenImage,0.1);
            profileimgByteStr=[[NSString alloc]init];
            profileimgByteStr= [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            // profileimgByteStr=[profileimgByteStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
    //[self performSelector:@selector(pushView) withObject:nil afterDelay:0.2];
}

-(void)viewDidAppear:(BOOL)animated{

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==address1Txt){
        [stateTxt becomeFirstResponder];
    }else if(textField==stateTxt){
        [cityTxt becomeFirstResponder];
    }else if(textField==cityTxt){
        [zipTxt becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
-(void)doneWithNumberPad{
    [PhonenoTxt resignFirstResponder];
    [phoneToolbar resignFirstResponder];
    [zipToolbar resignFirstResponder];
    [zipTxt resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==PhonenoTxt){
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int length = [currentString length];
        if (length > 12) {
            return NO;
        }
        
    }
    int length = [self getLength:PhonenoTxt.text];
    if(length == 12) {
        if(range.length == 0)
            return NO;
    }
    if(length == 3){
        NSString *num = [self formatNumber:PhonenoTxt.text];
        PhonenoTxt.text = [NSString stringWithFormat:@"%@-",num];
        
        if(range.length > 0) {
            PhonenoTxt.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
            
        }
    } else if(length == 6) {
        NSString *num = [self formatNumber:PhonenoTxt.text];
        PhonenoTxt.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        if(range.length > 0) {
            PhonenoTxt.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    else if(textField==zipTxt){
        
        if (zipTxt.text.length >= MAX_LENGTH && range.length == 0)
        {
            return NO; // return NO to not change text
        }
        else
        {return YES;
        }
    }
    else if (textField==DriverLecIDTxt){
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"  .0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        return YES;
    }
    return YES;
}


-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}
-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    return length;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    if (textField ==dateofBirthTxt) {
//        toolbarstate.hidden=YES;
//        statepickerview.hidden=YES;
//        datePicker.hidden=YES;
//        toolbarmarital.hidden=YES;
//        maritalpickerview.hidden=YES;
//        toolbargender.hidden=YES;
//        genderpickerview.hidden=YES;
//        cityToolbar.hidden=YES;
//        cityPickerview.hidden=YES;
//        [firstNameTxt resignFirstResponder];
//        [lastNameTxt resignFirstResponder];
//        [address1Txt resignFirstResponder];
//        [address2Txt resignFirstResponder];
//        [cityTxt resignFirstResponder];
//        [zipTxt resignFirstResponder];
//        [PhonenoTxt resignFirstResponder];
//        [stateTxt resignFirstResponder];
//        [emailTxt resignFirstResponder];
//        
//        datePicker=[[UIDatePicker alloc]init];
//        datePicker.backgroundColor = [UIColor whiteColor];
//        datePicker.frame=CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37);
//        datePicker.datePickerMode = UIDatePickerModeDate;
//        [self.view addSubview:datePicker];
//        datePicker.timeZone = [NSTimeZone systemTimeZone];
//        
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//            dateToobar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
//        }else{
//            dateToobar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
//        }
//        [dateToobar setBarStyle:UIBarStyleBlackOpaque];
//        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtndateofbirth)];
//        [leftButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                  forState:UIControlStateNormal];
//        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//        
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtndateofbirth)];
//        [rightButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                   forState:UIControlStateNormal];
//        
//        dateToobar.items = @[rightButton,flex,leftButton];
//        [self.view addSubview:dateToobar];
//        
//        dateToobar.hidden=NO;
//        datePicker.hidden=NO;
//        return NO;
//    }else if(textField==stateTxt){
//        
//        dateToobar.hidden=NO;
//        datePicker.hidden=NO;
//        toolbarmarital.hidden=YES;
//        maritalpickerview.hidden=YES;
//        toolbargender.hidden=YES;
//        genderpickerview.hidden=YES;
//        cityToolbar.hidden=YES;
//        cityPickerview.hidden=YES;
//        stateStr=[[NSString alloc]init];
//        
//        [firstNameTxt resignFirstResponder];
//        [lastNameTxt resignFirstResponder];
//        [address1Txt resignFirstResponder];
//        [address2Txt resignFirstResponder];
//        [cityTxt resignFirstResponder];
//        [zipTxt resignFirstResponder];
//        [PhonenoTxt resignFirstResponder];
//        [stateTxt resignFirstResponder];
//        [emailTxt resignFirstResponder];
////
//        toolbarstate.hidden=YES;
//        statepickerview.hidden=YES;
//        statepickerview = [[UIPickerView alloc] init];
//        [statepickerview setDataSource: self];
//        [statepickerview setDelegate: self];
//        statepickerview.backgroundColor = [UIColor whiteColor];
//        [statepickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
//        statepickerview.showsSelectionIndicator = YES;
//        [statepickerview selectRow:2 inComponent:0 animated:YES];
//        [self.view addSubview: statepickerview];
//        statepickerview.hidden=NO;
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//            toolbarstate= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
//        }else{
//            toolbarstate= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
//        }
//        [toolbarstate setBarStyle:UIBarStyleBlackOpaque];
//        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressedstate)];
//        [leftButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                  forState:UIControlStateNormal];
//        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//        
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpressstate)];
//        [rightButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                   forState:UIControlStateNormal];
//        
//        toolbarstate.items = @[rightButton,flex,leftButton];
//        [self.view addSubview:toolbarstate];
//        
//        toolbarstate.hidden=NO;
//        [stateTxt resignFirstResponder];
//        return NO;
//        
//    }else if(textField==cityTxt){
//        cityStr=[[NSString alloc]init];
//        dateToobar.hidden=NO;
//        datePicker.hidden=NO;
//        toolbarmarital.hidden=YES;
//        maritalpickerview.hidden=YES;
//        toolbargender.hidden=YES;
//        genderpickerview.hidden=YES;
//        
//        cityToolbar.hidden=YES;
//        cityPickerview.hidden=YES;
//        
//        [firstNameTxt resignFirstResponder];
//        [lastNameTxt resignFirstResponder];
//        [address1Txt resignFirstResponder];
//        [address2Txt resignFirstResponder];
//        [cityTxt resignFirstResponder];
//        [zipTxt resignFirstResponder];
//        [PhonenoTxt resignFirstResponder];
//        [stateTxt resignFirstResponder];
//        [emailTxt resignFirstResponder];
//        
//        if ([stateTxt.text isEqualToString:@""]) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Please select state first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            [stateTxt becomeFirstResponder];
//        }else{
//            cityToolbar.hidden=YES;
//            cityPickerview.hidden=YES;
//            cityPickerview = [[UIPickerView alloc] init];
//            [cityPickerview setDataSource: self];
//            [cityPickerview setDelegate: self];
//            cityPickerview.backgroundColor = [UIColor whiteColor];
//            [cityPickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
//            cityPickerview.showsSelectionIndicator = YES;
//            [cityPickerview selectRow:2 inComponent:0 animated:YES];
//            [self.view addSubview: cityPickerview];
//            cityPickerview.hidden=NO;
//            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//                cityToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
//            }else{
//                cityToolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
//            }
//            [cityToolbar setBarStyle:UIBarStyleBlackOpaque];
//            UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressedCity)];
//            [leftButton setTitleTextAttributes:
//             [NSDictionary dictionaryWithObjectsAndKeys:
//              [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                      forState:UIControlStateNormal];
//            UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//            
//            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpressCity)];
//            [rightButton setTitleTextAttributes:
//             [NSDictionary dictionaryWithObjectsAndKeys:
//              [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                       forState:UIControlStateNormal];
//            
//            cityToolbar.items = @[rightButton,flex,leftButton];
//            [self.view addSubview:cityToolbar];
//            
//            cityToolbar.hidden=NO;
//            [cityTxt resignFirstResponder];
//            return NO;
//        }
//        return NO;
//    }else if(textField==maritalstatusTxt){
//        maritalStr=[[NSString alloc]init];
//        dateToobar.hidden=YES;
//        datePicker.hidden=YES;
//        toolbarstate.hidden=YES;
//        statepickerview.hidden=YES;
//        toolbargender.hidden=YES;
//        genderpickerview.hidden=YES;
//        cityToolbar.hidden=YES;
//        cityPickerview.hidden=YES;
//        
//        [firstNameTxt resignFirstResponder];
//        [lastNameTxt resignFirstResponder];
//        [address1Txt resignFirstResponder];
//        [address2Txt resignFirstResponder];
//        [cityTxt resignFirstResponder];
//        [zipTxt resignFirstResponder];
//        [PhonenoTxt resignFirstResponder];
//        [stateTxt resignFirstResponder];
//        [emailTxt resignFirstResponder];
//        
//        toolbarmarital.hidden=YES;
//        maritalpickerview.hidden=YES;
//        maritalpickerview = [[UIPickerView alloc] init];
//        [maritalpickerview setDataSource: self];
//        [maritalpickerview setDelegate: self];
//        maritalpickerview.backgroundColor = [UIColor whiteColor];
//        [maritalpickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
//        maritalpickerview.showsSelectionIndicator = YES;
//        [maritalpickerview selectRow:2 inComponent:0 animated:YES];
//        [self.view addSubview: maritalpickerview];
//        maritalpickerview.hidden=NO;
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//            toolbarmarital= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
//        }else{
//            toolbarmarital= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
//        }
//        [toolbarmarital setBarStyle:UIBarStyleBlackOpaque];
//        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressedmarital)];
//        [leftButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                  forState:UIControlStateNormal];
//        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//        
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpressmarital)];
//        [rightButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                   forState:UIControlStateNormal];
//        
//        toolbarmarital.items = @[rightButton,flex,leftButton];
//        [self.view addSubview:toolbarmarital];
//        
//        toolbarmarital.hidden=NO;
//        [maritalstatusTxt resignFirstResponder];
//        return NO;
//        
//    }else if(textField==genderTxt){
//        genderStr=[[NSString  alloc]init];
//        dateToobar.hidden=YES;
//        datePicker.hidden=YES;
//        toolbarstate.hidden=YES;
//        statepickerview.hidden=YES;
//        toolbargender.hidden=YES;
//        genderpickerview.hidden=YES;
//        cityToolbar.hidden=YES;
//        cityPickerview.hidden=YES;
//        
//        genderArray=[[NSMutableArray alloc]initWithObjects:@"Male",@"Female",nil];
//        
//        //[genderTxt setText:[NSString stringWithFormat:@"%@",[genderArray objectAtIndex:0]]];
//        [firstNameTxt resignFirstResponder];
//        [lastNameTxt resignFirstResponder];
//        [address1Txt resignFirstResponder];
//        [address2Txt resignFirstResponder];
//        [cityTxt resignFirstResponder];
//        [zipTxt resignFirstResponder];
//        [PhonenoTxt resignFirstResponder];
//        [stateTxt resignFirstResponder];
//        [emailTxt resignFirstResponder];
//        
//        toolbargender.hidden=YES;
//        genderpickerview.hidden=YES;
//        genderpickerview = [[UIPickerView alloc] init];
//        [genderpickerview setDataSource: self];
//        [genderpickerview setDelegate: self];
//        genderpickerview.backgroundColor = [UIColor whiteColor];
//        [genderpickerview setFrame: CGRectMake(0,screenRect.size.height*0.63,self.view.bounds.size.width,screenRect.size.height*0.37)];
//        genderpickerview.showsSelectionIndicator = YES;
//        [genderpickerview selectRow:2 inComponent:0 animated:YES];
//        [self.view addSubview: genderpickerview];
//        genderpickerview.hidden=NO;
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//            toolbargender= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,44)];
//        }else{
//            toolbargender= [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.57,self.view.bounds.size.width,64)];
//        }
//        [toolbargender setBarStyle:UIBarStyleBlackOpaque];
//        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneBtnPressedgender)];
//        [leftButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                  forState:UIControlStateNormal];
//        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//        
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBtnpressgender)];
//        [rightButton setTitleTextAttributes:
//         [NSDictionary dictionaryWithObjectsAndKeys:
//          [UIColor whiteColor], NSForegroundColorAttributeName,nil]
//                                   forState:UIControlStateNormal];
//        
//        toolbargender.items = @[rightButton,flex,leftButton];
//        [self.view addSubview:toolbargender];
//        
//        toolbargender.hidden=NO;
//        [genderTxt resignFirstResponder];
//        return NO;
//        
//    }else{
//        
        int tags=textField.tag;
        if (tags==1) {
            [self animateTextField:textField up:YES];
        }else if (tags==2) {
            [self animateTextField:textField up:YES];
        }else if (tags==3) {
            [self animateTextField:textField up:YES];
        }else if (tags==4){
            [self animateTextField:textField up:YES];
        }else if (tags==5){
            [self animateTextField:textField up:YES];
        }else if (tags==6){
            [self animateTextField:textField up:YES];
        }
    //}
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
    return YES;
}
-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    int movementDistance=0;
    int tags=textField.tag;
    if (tags==1) {
        movementDistance = -170; // tweak as needed
    }else if (tags==2){
        movementDistance = -170; // tweak as needed
    }else if (tags==3){
        movementDistance = -200; // tweak as needed
    }else if (tags==4){
        movementDistance = -220; // tweak as needed
    }else if (tags==5){
        movementDistance = -250; // tweak as needed
    }else if (tags==6){
        movementDistance = -250; // tweak as needed
    }
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int tags=textField.tag;
    if (tags==1){
        [self animateTextField:textField up:NO];
    }
    if (tags==2){
        [self animateTextField:textField up:NO];
    }
    if (tags==3){
        [self animateTextField:textField up:NO];
    }
    if (tags==4){
        [self animateTextField:textField up:NO];
    }
    if (tags==5){
        [self animateTextField:textField up:NO];
    }    if (tags==6){
        [self animateTextField:textField up:NO];
    }


}

-(IBAction)genderAction:(id)sender{
    
    switch ([sender tag]) {
        case 1:
            if([genderMaleBtn isSelected]==YES)
            {
                [genderMaleBtn setSelected:NO];
                [genderfemaleBtn setSelected:YES];
                genderStr=@"Female";
            }
            else{
                [genderMaleBtn setSelected:YES];
                [genderfemaleBtn setSelected:NO];
                genderStr=@"Male";
            }
            break;
        case 2:
            if([genderfemaleBtn isSelected]==YES)
            {
                [genderfemaleBtn setSelected:NO];
                [genderMaleBtn setSelected:YES];
                genderStr=@"Male";
            }
            else{
                [genderfemaleBtn setSelected:YES];
                [genderMaleBtn setSelected:NO];
                genderStr=@"Female";
            }
            break;
    }
}

-(IBAction)doneBtnPressedstate{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
    if (![stateTxt.text isEqualToString:stateStr]) {
        [activityImageView removeFromSuperview];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *urlString=[prefs objectForKey:@"SWACC"];
        
        if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
            [self performSelector:@selector(getCitysnames1) withObject:nil afterDelay:1.0 ];
        }else{
        [self performSelector:@selector(getCitysnames) withObject:nil afterDelay:1.0 ];
        }
        cityTxt.text=@"";
        cityid=0;
    }
    stateTxt.text=stateStr;
    iscityPicker=true;
}
-(IBAction)cancelBtnpressstate{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
}

-(IBAction)doneBtnPressedCity{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityTxt.text=cityStr;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
}
-(IBAction)cancelBtnpressCity{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
}

-(IBAction)doneBtnPressedmarital{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
    
    maritalstatusTxt.text=maritalStr;
}
-(IBAction)cancelBtnpressmarital{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
}
-(IBAction)doneBtnPressedgender{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
    
    if ([genderStr isEqualToString:@"Male"]) {
        genderId=1;
    }else if ([genderStr isEqualToString:@"Female"]) {
        genderId=2;
    }else if ([genderStr isEqualToString:@"Others"]) {
        genderId=3;
    }
    genderTxt.text=genderStr;
}
-(IBAction)cancelBtnpressgender{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
}

-(IBAction)doneBtndateofbirth{
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *secondDate = [NSDate date];
    NSString *selectdate =[dateFormatters stringFromDate:datePicker.date];
    secondDate = [dateFormatters dateFromString:selectdate];
    
    
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatterss = [[NSDateFormatter alloc] init];
    [dateFormatterss setDateFormat:@"yyyy-MM-dd"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatterss dateFromString:selectdate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    
    if (years<18) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Date of birth invalid" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        dateofBirthTxt.text = [dateFormatters stringFromDate:datePicker.date];
    }
    NSLog(@"You live since %i years and %i days",years,days);
    
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    dateToobar.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
}

-(IBAction)cancelBtndateofbirth{
    toolbarstate.hidden=YES;
    statepickerview.hidden=YES;
    datePicker.hidden=YES;
    toolbarmarital.hidden=YES;
    maritalpickerview.hidden=YES;
    toolbargender.hidden=YES;
    genderpickerview.hidden=YES;
    dateToobar.hidden=YES;
    cityToolbar.hidden=YES;
    cityPickerview.hidden=YES;
}

- (int)timeDifference:(NSDate *)fromDate ToDate:(NSDate *)toDate{
    NSTimeInterval distanceBetweenDates = [toDate timeIntervalSinceDate:fromDate];
    
    return distanceBetweenDates;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: statepickerview]) {
        return [stateArray count];
    }
    else if ([pickerView isEqual: maritalpickerview]) {
        return [maritalArray count];
    }else if ([pickerView isEqual: genderpickerview]) {
        return [genderArray count];
    }else if ([pickerView isEqual: cityPickerview]) {
        return [cityArray count];
    }
    else{
        return 0;
    }
}


// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *rowItem;
    
    if (pickerView == statepickerview)
    {
        StateVO *stateVo=[[StateVO alloc]init];
        stateVo= [stateArray objectAtIndex: row];
        rowItem = stateVo.StateNameStr;
    }
    
    if (pickerView == cityPickerview)
    {
        CityVO *scityVo=[[CityVO alloc]init];
        scityVo= [cityArray objectAtIndex: row];
        rowItem = scityVo.CityNameStr;
    }
    
    if (pickerView == maritalpickerview)
    {
        MaritalStatusVO *stateVo=[[MaritalStatusVO alloc]init];
        stateVo= [maritalArray objectAtIndex: row];
        rowItem = stateVo.maritalNameStr;
    }
    if (pickerView == genderpickerview)
    {
        rowItem = [genderArray objectAtIndex: row];
    }
    
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:UITextAlignmentCenter];
    [lblRow setTextColor: [UIColor blackColor]];
    [lblRow setText:rowItem];
    UIFont * fonts =[UIFont fontWithName:@"Open Sans" size:15.0f];
    lblRow.font=fonts;
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView ==statepickerview)
    {
        stateStr=[[NSString alloc]init];
        StateVO *stateVo=[[StateVO alloc]init];
        stateVo= [stateArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        stateStr = stateVo.StateNameStr;
        stateid=[stateVo.idStr intValue];
        //stateStr=[NSString stringWithFormat:@"%@",[stateArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    if (pickerView ==cityPickerview)
    {
        cityStr=[[NSString alloc]init];
        CityVO *scityVo=[[CityVO alloc]init];
        scityVo= [cityArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        cityStr = scityVo.CityNameStr;
        cityid=[scityVo.idStr intValue];
        
        //stateStr=[NSString stringWithFormat:@"%@",[stateArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
    
    if (pickerView ==maritalpickerview)
    {
        maritalStr=[[NSString alloc]init];
        MaritalStatusVO *stateVo=[[MaritalStatusVO alloc]init];
        stateVo= [maritalArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        maritalStr = stateVo.maritalNameStr;
        maritalId=[stateVo.maritalidStr intValue];
        
    }if (pickerView ==genderpickerview)
    {
        genderStr=[[NSString alloc]init];
        genderStr=[NSString stringWithFormat:@"%@",[genderArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == statepickerview)
    {
        return [stateArray objectAtIndex:row];
    }
    if (pickerView == maritalpickerview)
    {
        return [maritalArray objectAtIndex:row];
    }
    if (pickerView == genderpickerview)
    {
        return [genderArray objectAtIndex:row];
    }
    if (pickerView == cityPickerview)
    {
        return [cityArray objectAtIndex:row];
    }
    
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 300.0;
    return componentWidth;
}
-(void)getgetMaritalStatusdata
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
        maritalArray=[[NSMutableArray alloc]init];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"taskName=getMaritalStatus"]];
        NSString *urlString = [[NSString alloc]initWithFormat:@"%@wsListOfValues.php",[prefs objectForKey:@"LinkHRlift"]];
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                [activityImageView removeFromSuperview];
                NSLog(@"Failed to submit request");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Internet error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                NSError *error;
                if ([content isEqualToString:@""]) {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid user name or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                }
                else {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSString *result = [[NSString alloc]init];
                    result =[userDict objectForKey:@"result"];
                    NSString *message = [[NSString alloc]init];
                    message = [userDict objectForKey:@"message"];
                    int boolValue = [result intValue];
                    NSArray *userArray = [userDict objectForKey:@"message"];
                    for (int count=0; count<[userArray count]; count++) {
                        NSDictionary *activityData=[userArray objectAtIndex:count];
                        MaritalStatusVO *marVO=[[MaritalStatusVO alloc]init];
                        if ([activityData objectForKey:@"id"] != [NSNull null])
                            marVO.maritalidStr=[activityData objectForKey:@"id"];
                        
                        if ([activityData objectForKey:@"maritalstatusname"] != [NSNull null])
                            marVO.maritalNameStr=[activityData objectForKey:@"maritalstatusname"];
                        
                        [maritalArray addObject:marVO];
                    }
                    [activityImageView removeFromSuperview];
                }
            }
        }];
    }
}
-(void)getStatenames
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
        stateArray=[[NSMutableArray alloc]init];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"taskName=getState"]];
        NSString *urlStringweb;
        NSString *urlString=[prefs objectForKey:@"SWACC"];
        if ([urlString isEqualToString:@"https://23.253.109.178/chatws/"]) {
            [self performSelector:@selector(getStatenames1) withObject:nil afterDelay:1.0 ];
        }else{
             urlStringweb= [[NSString alloc]initWithFormat:@"%@wsListOfValues.php?",[prefs objectForKey:@"LinkHRlift"]];
        url=[[NSURL alloc] initWithString:urlStringweb];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                [activityImageView removeFromSuperview];
                NSLog(@"Failed to submit request");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Internet error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                if (![content isEqualToString:@""]) {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    
                    NSArray *userArray = [userDict objectForKey:@"message"];
                    for (int count=0; count<[userArray count]; count++) {
                        
                        NSDictionary *activityData=[userArray objectAtIndex:count];
                        StateVO *stateVo=[[StateVO alloc]init];
                        stateVo.idStr=[[NSString alloc] init];
                        stateVo.StateNameStr=[[NSString alloc] init];
                        
                        if ([activityData objectForKey:@"id"] != [NSNull null])
                            stateVo.idStr=[activityData objectForKey:@"id"];
                        
                        if ([activityData objectForKey:@"state_name"] != [NSNull null])
                            stateVo.StateNameStr=[activityData objectForKey:@"state_name"];
                        
                        [stateArray addObject:stateVo];
                    }
                }
                [activityImageView removeFromSuperview];
               // [self getgetMaritalStatusdata];
            }
        }];
        }
    }
}
-(void)getgetMaritalStatusdata1{
    maritalArray=[[NSMutableArray alloc]init];

    commonUrl=@"getMaritalStatus";
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"taskName=getMaritalStatus"]];
    
    urlString = [[NSString alloc]initWithFormat:@"%@wsListOfValues.php",[prefs objectForKey:@"LinkHRlift"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
}

-(void)getStatenames1{
    stateArray=[[NSMutableArray alloc]init];
    commonUrl=@"getState";
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"taskName=getState"]];
    
    urlString= [[NSString alloc]initWithFormat:@"%@wsListOfValues.php?",[prefs objectForKey:@"LinkHRlift"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
}
-(void)getCitysnames1{
    cityArray=[[NSMutableArray alloc]init];

    commonUrl=@"getCity";
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"taskName=getCity&stateId=%d",stateid]];
    
   urlString = [[NSString alloc]initWithFormat:@"%@wsListOfValues.php",[prefs objectForKey:@"LinkHRlift"]];
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
    if ([commonUrl isEqualToString:@"getState"]) {
    NSArray *userArray = [dic objectForKey:@"message"];
    for (int count=0; count<[userArray count]; count++) {
        
        NSDictionary *activityData=[userArray objectAtIndex:count];
        StateVO *stateVo=[[StateVO alloc]init];
        stateVo.idStr=[[NSString alloc] init];
        stateVo.StateNameStr=[[NSString alloc] init];
        
        if ([activityData objectForKey:@"id"] != [NSNull null])
            stateVo.idStr=[activityData objectForKey:@"id"];
        
        if ([activityData objectForKey:@"state_name"] != [NSNull null])
            stateVo.StateNameStr=[activityData objectForKey:@"state_name"];
        
        [stateArray addObject:stateVo];
    }
        
        [activityImageView removeFromSuperview];
       // [self getgetMaritalStatusdata1];
  
    }else if ([commonUrl isEqualToString:@"getMaritalStatus"]){
        NSString *result = [[NSString alloc]init];
        result =[dic objectForKey:@"result"];
        NSString *message = [[NSString alloc]init];
        message = [dic objectForKey:@"message"];
        int boolValue = [result intValue];
        NSArray *userArray = [dic objectForKey:@"message"];
        for (int count=0; count<[userArray count]; count++) {
            NSDictionary *activityData=[userArray objectAtIndex:count];
            MaritalStatusVO *marVO=[[MaritalStatusVO alloc]init];
            if ([activityData objectForKey:@"id"] != [NSNull null])
                marVO.maritalidStr=[activityData objectForKey:@"id"];
            
            if ([activityData objectForKey:@"maritalstatusname"] != [NSNull null])
                marVO.maritalNameStr=[activityData objectForKey:@"maritalstatusname"];
            
            [maritalArray addObject:marVO];
        }
        [activityImageView removeFromSuperview];
    }else if ([commonUrl isEqualToString:@"getCity"]){
        NSArray *userArray = [dic objectForKey:@"message"];
        for (int count=0; count<[userArray count]; count++) {
            
            NSDictionary *activityData=[userArray objectAtIndex:count];
            CityVO *cityVo=[[CityVO alloc]init];
            cityVo.idStr=[[NSString alloc] init];
            cityVo.CityNameStr=[[NSString alloc] init];
            
            if ([activityData objectForKey:@"id"] != [NSNull null])
                cityVo.idStr=[activityData objectForKey:@"id"];
            
            if ([activityData objectForKey:@"city_name"] != [NSNull null])
                cityVo.CityNameStr=[activityData objectForKey:@"city_name"];
            
            [cityArray addObject:cityVo];
        }
    if (iscityPicker==false) {
        for (int count=0; count<[cityArray count]; count++) {
            CityVO *cityVo=[cityArray objectAtIndex:count];
            int curcityid=[cityVo.idStr intValue];
            if (cityid==curcityid) {
                cityTxt.text=cityVo.CityNameStr;
            }
        }
    }
    [activityImageView removeFromSuperview];
    }else if ([commonUrl isEqualToString:@"postData"]){
        NSString *result = [[NSString alloc]init];
        result =[dic objectForKey:@"result"];
        int boolValue = [result intValue];
        if (boolValue==1) {
            [prefs setObject:result forKey:@"Register"];
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:address1Txt.text forKey:@"workaddress"];
            [prefs setObject:stateTxt.text forKey:@"state"];
            [prefs setObject:cityTxt.text forKey:@"city"];
            [prefs setObject:zipTxt.text forKey:@"zipcode"];
            [prefs setObject:PhonenoTxt.text forKey:@"mobile"];
            [prefs setObject:jobtitleTxt.text forKey:@"jobtitle"];
            [prefs synchronize];

            [activityImageView removeFromSuperview];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Registration successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
//            MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//            appDelegate.index=0;
//            [self.navigationController pushViewController:mainvc animated:YES];
        }else {
            NSString *msg=[NSString stringWithFormat:@"Internet error"];
            [activityImageView removeFromSuperview];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
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

-(void)getCitysnames
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
        cityArray=[[NSMutableArray alloc]init];
        NSURL *url;
        NSMutableString *httpBodyString;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"taskName=getCity&stateId=%d",stateid]];
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"%@wsListOfValues.php?",[prefs objectForKey:@"LinkHRlift"]];
        
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            // your data or an error will be ready here
            if (error)
            {
                [activityImageView removeFromSuperview];
                NSLog(@"Failed to submit request");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid current password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            else
            {
                [activityImageView removeFromSuperview];
                NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                              length:[data length] encoding: NSUTF8StringEncoding];
                if (![content isEqualToString:@""]) {
                    NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    
                    NSArray *userArray = [userDict objectForKey:@"message"];
                    for (int count=0; count<[userArray count]; count++) {
                        
                        NSDictionary *activityData=[userArray objectAtIndex:count];
                        CityVO *cityVo=[[CityVO alloc]init];
                        cityVo.idStr=[[NSString alloc] init];
                        cityVo.CityNameStr=[[NSString alloc] init];
                        
                        if ([activityData objectForKey:@"id"] != [NSNull null])
                            cityVo.idStr=[activityData objectForKey:@"id"];
                        
                        if ([activityData objectForKey:@"city_name"] != [NSNull null])
                            cityVo.CityNameStr=[activityData objectForKey:@"city_name"];
                        
                        [cityArray addObject:cityVo];
                        
                    }
                }
                
                if (iscityPicker==false) {
                    for (int count=0; count<[cityArray count]; count++) {
                        CityVO *cityVo=[cityArray objectAtIndex:count];
                        int curcityid=[cityVo.idStr intValue];
                        if (cityid==curcityid) {
                            cityTxt.text=cityVo.CityNameStr;
                        }
                    }
                    
                }
                [activityImageView removeFromSuperview];
                
            }
        }];
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

-(void)updateAction1{
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    [self.navigationController pushViewController:mainvc animated:YES];
}
- (IBAction)UpdateAction:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:[prefs objectForKey:@"NOINTERNET"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        if ( [address1Txt.text isEqualToString:@""] && [cityTxt.text isEqualToString:@""] && [zipTxt.text isEqualToString:@""] && [stateTxt.text isEqualToString:@""] ) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Fields are mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
                    if ([address1Txt.text isEqualToString:@""]) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Address 1   field is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        [address1Txt becomeFirstResponder];
                    }
                    else{
                        if ([cityTxt.text isEqualToString:@""]) {
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"City field is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            [cityTxt becomeFirstResponder];
                        }
                        else{
                            if ([stateTxt.text isEqualToString:@""]) {
                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"State field is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                                [stateTxt becomeFirstResponder];
                            }
                            else{
                                if ([zipTxt.text isEqualToString:@""]) {
                                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Zip code field is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    [zipTxt becomeFirstResponder];
                                }
                                else{
//                                    if ([maritalstatusTxt.text isEqualToString:@""]) {
//                                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Marital status field is mandatory" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                        [alert show];
//                                        [maritalstatusTxt becomeFirstResponder];
//                                    }else{
                                        NSString *pinno=zipTxt.text;
                                        int lengthZip = [pinno length];
                                        if (lengthZip == 5) {
                                            
                                            if (![PhonenoTxt.text isEqualToString:@""]) {
                                                NSString *pHno=PhonenoTxt.text;
                                                int lengthZip = [pHno length];
                                                if (lengthZip == 12) {
                                                        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
                                                        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                                                        NSString *urlString=[prefs objectForKey:@"SWACC"];
                                                        
                                                        if ([urlString isEqualToString:@"https://23.253.109.178/swacc/"]) {
                                                            [self performSelector:@selector(postData1) withObject:nil afterDelay:1.0 ];
                                                        }else{
                                                            [self performSelector:@selector(postData) withObject:nil afterDelay:1.0 ];
                                                        }
                                                        
                                                }else{
                                                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                    [alert show];
                                                    
                                                    [PhonenoTxt becomeFirstResponder];
                                                }
                                            }else{
                                                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [alert show];
                                            }
                                        }else{
                                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Invalid zip code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [alert show];
                                            [zipTxt becomeFirstResponder];
                            }
                        }
                    }
                }
            }
        }
    }
}

-(void)postData1{
    commonUrl=@"postData";
    NSURL *url;
    NSMutableString *httpBodyString;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (profileimgByteStr==nil) {
        NSData *imageData = UIImageJPEGRepresentation(photoImageview.image,0.1);
        profileimgByteStr=[[NSString alloc]init];
        profileimgByteStr= [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }

    httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&address=%@&state=%@&city=%@&zipcode=%@&profile_picture=%@&job_title=%@&mobile=%@",[prefs objectForKey:@"user_id"],address1Txt.text,stateTxt.text,cityTxt.text,zipTxt.text,profileimgByteStr,jobtitleTxt.text,PhonenoTxt.text]];
    
    urlString = [[NSString alloc]initWithFormat:@"%@wsUpdatePersonalInformation.php",[prefs objectForKey:@"SWACC"]];
    url=[[NSURL alloc] initWithString:urlString];
    rest_url=url;
    NSData *postData = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connections start];
}

-(void)postData{
    
    if (profileimgByteStr==nil) {
        NSData *imageData = UIImageJPEGRepresentation(photoImageview.image,0.1);
        profileimgByteStr=[[NSString alloc]init];
        profileimgByteStr= [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }

    NSURL *url;
    NSMutableString *httpBodyString;
    NSMutableURLRequest *urlRequest;
    NSString *urlString;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *urlString1=[prefs objectForKey:@"SWACC"];
    if ([urlString1 isEqualToString:@"http://192.168.0.37/swacc/"]) {
        httpBodyString=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"user_id=%@&address=%@&state=%@&city=%@&zipcode=%@&profile_picture=%@&job_title=%@&mobile=%@",[prefs objectForKey:@"user_id"],address1Txt.text,stateTxt.text,cityTxt.text,zipTxt.text,profileimgByteStr,jobtitleTxt.text,PhonenoTxt.text]];
        urlString = [[NSString alloc]initWithFormat:@"%@wsUpdatePersonalInformation.php",[prefs objectForKey:@"SWACC"]];
        url=[[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    }
    else
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[prefs objectForKey:@"user_id"] forKey:@"user_id"];
        [dict setValue:address1Txt.text forKey:@"address"];
        [dict setValue:stateTxt.text forKey:@"state"];
        [dict setValue:cityTxt.text forKey:@"city"];
        [dict setValue:zipTxt.text forKey:@"zipcode"];
        [dict setValue:profileimgByteStr forKey:@"profile_picture"];
        [dict setValue:jobtitleTxt.text forKey:@"job_title"];
        [dict setValue:PhonenoTxt.text forKey:@"mobile"];

        //convert object to data
        NSError *error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];

        urlRequest = [[NSMutableURLRequest alloc] init];
        //[request setURL:[NSURL URLWithString:@"http://192.168.0.192:9810/api/IdCard/UpdateImages"]];
        [urlRequest setURL:[NSURL URLWithString:@"https://stg.benefitbridge.com/swacc/api/user"]];
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
            // NSString *err=[NSString stringWithFormat:@"Server error %@",error];
            NSString *err=[NSString stringWithFormat:@"Internet error"];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:err delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else
        {
            NSString *content = [[NSString alloc]  initWithBytes:[data bytes]
                                                          length:[data length] encoding: NSUTF8StringEncoding];
            
            NSError *error;
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSString *result = [[NSString alloc]init];
            result =[userDict objectForKey:@"result"];
            int boolValue = [result intValue];
            if (boolValue==1) {
                [prefs setObject:result forKey:@"Register"];
                NSString *profilekey=[NSString stringWithFormat:@"%@%@",@"profile_picture",[prefs objectForKey:@"user_id"]];
                [prefs setObject:profileimgByteStr forKey:profilekey];

                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [prefs setObject:address1Txt.text forKey:@"workaddress"];
                [prefs setObject:stateTxt.text forKey:@"state"];
                [prefs setObject:cityTxt.text forKey:@"city"];
                [prefs setObject:zipTxt.text forKey:@"zipcode"];
                [prefs setObject:PhonenoTxt.text forKey:@"mobile"];
                [prefs setObject:jobtitleTxt.text forKey:@"jobtitle"];
                [prefs synchronize];

                [activityImageView removeFromSuperview];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:@"Registration successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

            }else {
                NSString *msg=[NSString stringWithFormat:@"Internet error"];
                [activityImageView removeFromSuperview];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"SWACC" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
        }
    }];
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
