//
//  RegistrationViewController.h
//  SWACC
//
//  Created by Infinitum on 19/11/16.
//  Copyright © 2016 com.keenan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomIOS7AlertView.h"

@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,CustomIOS7AlertViewDelegate,UIImagePickerControllerDelegate>
{
    NSURL *rest_url;
    
}
@property(nonatomic,retain) AppDelegate * appDelegate;
@property(strong,nonatomic)IBOutlet UITextField *firstNameTxt,*lastNameTxt,*genderTxt,*dateofBirthTxt,*maritalstatusTxt,*PhonenoTxt,*emailTxt,*address1Txt,*address2Txt,*cityTxt,*stateTxt,*zipTxt,*DriverLecIDTxt,*DriverLecIDExpirydateTxt,*DriverLecIDissuingstateTxt,*jobtitleTxt;
@property(strong,nonatomic)IBOutlet UILabel *firstnameLbl,*lastnameLbl,*genderLbl,*dateofBirthLbl,*maritalstatusLbl,*phonenoLbl,*emailLbl,*address1Lbl,*address2Lbl,*cityLbl,*stateLbl,*zipLbl,*DriverLecIDLbl,*DriverLecIDExpirydateLbl,*DriverLecIDissuingstateLbl,*exemptLbl,*exempt1Lbl,*exemptnon2Lbl,*uploadsignPictLbl;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIDatePicker *datePicker,*datePickerdriverexpDate;
@property(nonatomic,retain) IBOutlet UIToolbar *dateToobar,*datedriverexpToolbar;
@property(nonatomic,retain) UIToolbar* phoneToolbar,* zipToolbar;
@property(nonatomic,retain) NSMutableArray *genderArray,*maritalArray,*stateArray,*cityArray;
@property(nonatomic,retain) IBOutlet UIPickerView *genderpickerview,*maritalpickerview,*statepickerview,*cityPickerview,*drivingPickerview;
@property(nonatomic,retain) IBOutlet UIToolbar *toolbargender,*toolbarmarital,*toolbarstate,*cityToolbar,*driverToolbar;
@property(nonatomic,retain)NSString *stateStr,*driverState,*maritalStr,*genderStr,*cityStr,*profileimgByteStr,*signImgbyteStr,*commonUrl;
@property(nonatomic,retain)UIButton *genderMaleBtn,*genderfemaleBtn;
@property(nonatomic,retain)UIButton *exemptBtn,*nonexemptBtn,*signimgBtn,*updateBtn,*clearsignBtn;
@property(nonatomic,retain)UIImageView *activityImageView;
@property(nonatomic,readwrite)int stateid,cityid,genderId,maritalId;
@property(nonatomic,readwrite) BOOL iscityPicker;
@property(nonatomic,retain)UIImageView *photoImageview;
@property(nonatomic,retain) CustomIOS7AlertView *profilealertView;
@end
