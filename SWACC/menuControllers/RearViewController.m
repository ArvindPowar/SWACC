
/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 
*/
#import "RearViewController.h"
#import "UIColor+Expanded.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "MainViewController.h"
#import "MenuVO.h"
#import "MemberpolicyViewController.h"
@interface RearViewController(){
    NSMutableDictionary *sectionContentDict;
    NSMutableArray      *arrayForBool;
    NSIndexPath *selectedIndexPath;
}


@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;
@synthesize appDelegate,usernameLabel,displayUserName,imageBtn,mainmenuArray,submenuArray,listofcourseBtn,isvisible,issubjectvis,subjectbtn,issubjectexpand,datelocationBtn,indexImage,indeximage1,indeximage2;

#pragma mark - View lifecycle


- (void)viewDidLoad
{
	[super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor=[UIColor colorWithHexString:@"851c2b"];
	self.rearTableView.backgroundColor=[UIColor colorWithHexString:@"851c2b"];
    self.navigationController.navigationBarHidden=YES;
    [imageBtn.layer setFrame:CGRectMake(10,13,60,60)];
    [imageBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:imageBtn];
    
    selectedIndexPath = [NSIndexPath new];
    isvisible=false;
    issubjectvis=false;
    issubjectexpand=false;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *profilekey=[NSString stringWithFormat:@"%@%@",@"profile_picture",[prefs objectForKey:@"user_id"]];
    UIImageView *  ProfileImg;
    ProfileImg=[[UIImageView alloc]initWithFrame:CGRectMake(15,15,50,50)];
    if ([prefs objectForKey:profilekey]!=nil && ![[prefs objectForKey:profilekey] isEqualToString:@""]) {
    NSData *nsdataBackBase64String = [[NSData alloc] initWithBase64EncodedString:[prefs objectForKey:profilekey] options:0];
    UIImage *img1 = [UIImage imageWithData: nsdataBackBase64String];
    ProfileImg.contentMode = UIViewContentModeScaleAspectFit;
    ProfileImg.image=img1;
    }else{
        [ProfileImg setImage:[UIImage imageNamed:@"upload_Picture copy.png"]];
    }
    ProfileImg.layer.cornerRadius = ProfileImg.frame.size.width / 2;
    ProfileImg.clipsToBounds = YES;
    ProfileImg.layer.borderWidth = 1.5f;
    ProfileImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:ProfileImg];
    
    usernameLabel =[[UILabel alloc]initWithFrame:CGRectMake(70,25,200,25)];
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    [usernameLabel setText:[NSString stringWithFormat:@"%@ %@",[prefs objectForKey:@"first_name"],[prefs objectForKey:@"last_name"]]];
    //usernameLabel.text@"James G john";
    usernameLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:18];
    usernameLabel.textColor=[UIColor whiteColor];
    usernameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    usernameLabel.numberOfLines = 0;
    usernameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:usernameLabel];
    
    UIImageView *  whiteback=[[UIImageView alloc]initWithFrame:CGRectMake(0,78,screenRect.size.width,1)];
    [whiteback setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
    [self.view addSubview:whiteback];

    NSString *name=[prefs objectForKey:@"userfullname"];
    NSString *lower = [name lowercaseString]; // this will be "hello, world!"
    NSString *fooUpper = [lower capitalizedString];

    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSLog(@"appVersionString:-%@",appVersionString);
    
    UILabel *versionLbl = [[UILabel alloc] init];
    [versionLbl setFrame:CGRectMake(screenRect.size.width*0.01,screenRect.size.height*0.95,screenRect.size.width*0.40,screenRect.size.height*0.05)];
    versionLbl.textAlignment = NSTextAlignmentLeft;
    [versionLbl setText:[NSString stringWithFormat:@"V %@",appVersionString]];
    [versionLbl setTextColor: [self colorFromHexString:@"#03687f"]];
    UIFont * font11 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:12.0f];
    versionLbl.font=font11;
    [self.view addSubview:versionLbl];

    submenuArray=[[NSMutableArray alloc]init];
    mainmenuArray=[[NSMutableArray alloc]init];
    arrayForBool=[[NSMutableArray alloc]init];
    mainmenuArray=[[NSMutableArray alloc]initWithObjects:@"SWACC Weekly Briefings",@"Listserv Communication",@"Upcoming Trainings\n& Initiatives",@"Member Contact Info",@"Meeting",@"My Profile",@"Sign Out",nil];
    
    for (int count=0; count<[mainmenuArray count]; count++) {
        MenuVO *gridVO=[[MenuVO alloc]init];
        gridVO.mainMenu=[[NSString alloc]init];
        gridVO.submenu=[[NSString alloc]init];
        gridVO.submenu=[NSString stringWithFormat:@"Task %d",count];
        gridVO.mainMenu=[mainmenuArray objectAtIndex:count];
        if (count==0) {
            
        }else if(count==2){
            gridVO.submenu=[NSString stringWithFormat:@"Video Training"];
            [submenuArray addObject:gridVO];
            
            MenuVO *gridVO=[[MenuVO alloc]init];
            gridVO.mainMenu=[[NSString alloc]init];
            gridVO.submenu=[[NSString alloc]init];
            gridVO.submenu=[NSString stringWithFormat:@"Live Training"];
            gridVO.mainMenu=[mainmenuArray objectAtIndex:count];
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            [submenuArray addObject:gridVO];

            MenuVO *gridVO1=[[MenuVO alloc]init];
            gridVO1.mainMenu=[[NSString alloc]init];
            gridVO1.submenu=[[NSString alloc]init];
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            gridVO1.mainMenu=[mainmenuArray objectAtIndex:count];
            gridVO1.submenu=[NSString stringWithFormat:@"Compliance Training Resources"];
            [submenuArray addObject:gridVO1];
            
            MenuVO *gridVOs=[[MenuVO alloc]init];
            gridVOs.mainMenu=[[NSString alloc]init];
            gridVOs.submenu=[[NSString alloc]init];
            gridVOs.submenu=[NSString stringWithFormat:@"Member policy Resources"];
            gridVOs.mainMenu=[mainmenuArray objectAtIndex:count];
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            [submenuArray addObject:gridVOs];

        }else if(count==3){
            gridVO.submenu=[NSString stringWithFormat:@"Chief Executive Officer"];
            [submenuArray addObject:gridVO];
            MenuVO *gridVO=[[MenuVO alloc]init];
            gridVO.mainMenu=[[NSString alloc]init];
            gridVO.submenu=[[NSString alloc]init];
            gridVO.submenu=[NSString stringWithFormat:@"Chief Financial Officer"];
            gridVO.mainMenu=[mainmenuArray objectAtIndex:count];
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            [submenuArray addObject:gridVO];
            
            MenuVO *gridVOs=[[MenuVO alloc]init];
            gridVOs.mainMenu=[[NSString alloc]init];
            gridVOs.submenu=[[NSString alloc]init];
            gridVOs.submenu=[NSString stringWithFormat:@"Chief Human Resource Officer"];
            gridVOs.mainMenu=[mainmenuArray objectAtIndex:count];
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            [submenuArray addObject:gridVOs];

            MenuVO *gridVO1=[[MenuVO alloc]init];
            gridVO1.mainMenu=[[NSString alloc]init];
            gridVO1.submenu=[[NSString alloc]init];
            gridVO1.submenu=[NSString stringWithFormat:@"Risk Manager"];
            gridVO1.mainMenu=[mainmenuArray objectAtIndex:count];
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            [submenuArray addObject:gridVO1];

            MenuVO *gridVO2=[[MenuVO alloc]init];
            gridVO2.mainMenu=[[NSString alloc]init];
            gridVO2.submenu=[[NSString alloc]init];
            gridVO2.submenu=[NSString stringWithFormat:@"SWACC Rep"];
            gridVO2.mainMenu=[mainmenuArray objectAtIndex:count];
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
            [submenuArray addObject:gridVO2];
            }
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
    }
    
    
    

}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}



//#pragma marl - UITableView Data Source
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	return 5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	static NSString *cellIdentifier = @"Cell";
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    NSInteger row = indexPath.row;
//	
//	if (nil == cell)
//	{
//		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//        cell.textLabel.textColor=[UIColor whiteColor];
//	}
//    
//    UIImageView *menuItemImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10,10,35,35)];
//    UILabel *pictureLbl=[[UILabel alloc]initWithFrame:CGRectMake(10,10,35,35)];
//    pictureLbl.text = @"";
//    pictureLbl.textColor=[UIColor grayColor];
//
//    
//    UILabel *menuItemTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 5, 250, 45)];
//    menuItemTextLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:16];
//    menuItemTextLabel.textColor=[UIColor colorWithHexString:@"03687F"];
//    cell.backgroundColor=[UIColor clearColor];
//	if (row == 0)
//	{
//        menuItemImageView.image=[UIImage imageNamed:@"home.png"];
//        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
//        pictureLbl.text = @"\uf015";
//
//		menuItemTextLabel.text = @"Top News";
//    }
//    else if (row == 1)
//    {
//        menuItemImageView.image=[UIImage imageNamed:@"user.png"];
//        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
//        pictureLbl.text = @"\uf015";
//        
//        menuItemTextLabel.text = @"Listserv Communication";
//    }
//	else if (row == 1)
//	{
//		menuItemImageView.image=[UIImage imageNamed:@"password.png"];
//        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
//        pictureLbl.text = @"\uf0eb";
//
//		menuItemTextLabel.text = @"EPL";
//	}
//	else if (row == 2)
//	{
//        menuItemImageView.image=[UIImage imageNamed:@"user.png"];
//        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
//        pictureLbl.text = @"\uf015";
//        
//        menuItemTextLabel.text = @"Title IX";
//    }else if (row == 3)
//    {
//        menuItemImageView.image=[UIImage imageNamed:@"log_out.png"];
//        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
//        pictureLbl.text = @"\uf083";
//        
//        menuItemTextLabel.text = @"Member Contact Info";
//    }else if (row == 4)
//    {
//        menuItemImageView.image=[UIImage imageNamed:@"log_out.png"];
//        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
//        pictureLbl.text = @"\uf083";
//        
//        menuItemTextLabel.text = @"Emergency Contacts";
//    }
////    else if (row == 2)
////    {
////        menuItemImageView.image=[UIImage imageNamed:@"log_out.png"];
////        pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:30];
////        pictureLbl.text = @"\uf083";
////        
////        menuItemTextLabel.text = @"Sign out";
////    }
//    [cell.contentView addSubview:menuItemImageView];
//    [cell.contentView addSubview:menuItemTextLabel];
//   // [cell.contentView addSubview:pictureLbl];
//
//	return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	// Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
//    NSInteger row = indexPath.row;
//    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    appDelegate.index=row;
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
//    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
//    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
//    }


#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [mainmenuArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[arrayForBool objectAtIndex:section] boolValue]) {
        NSString *  personname;
        personname= [mainmenuArray objectAtIndex:section];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mainMenu = %@", personname];
        NSArray *filterArray = [submenuArray filteredArrayUsingPredicate:predicate];
        return [filterArray count];
    }
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(10, 0, tableView.frame.size.width, 50.0)];
    
    [sectionHeaderView setBackgroundColor:[UIColor colorWithHexString:@"851c2b"]];
    UILabel *pictureLbl=[[UILabel alloc]initWithFrame:CGRectMake(5,10,35,35)];
    pictureLbl.textColor=[UIColor whiteColor];
    pictureLbl.font = [UIFont fontWithName:@"FontAwesome" size:20];
    if (section==0){
    pictureLbl.text = @"\uf1ea";
    }
    if (section==1){
        pictureLbl.text = @"\uf0e6";
    }
    if (section==2){
        pictureLbl.text = @"\uf1ea";
    }
    if (section==3){
        pictureLbl.text = @"\uf1ea";
    }
    if (section==4){
        pictureLbl.text = @"\uf15c";
    }
    if (section==5){
        pictureLbl.text = @"\uf15c";
    }
    if (section==6){
        pictureLbl.text = @"\uf007";
    }
    if (section==7){
        pictureLbl.text = @"\uf08b";
    }
    [sectionHeaderView addSubview:pictureLbl];
    
    selectedIndexPath = [NSIndexPath new];
    isvisible=false;
    issubjectvis=false;
    issubjectexpand=false;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(40,0,sectionHeaderView.frame.size.width-90,50)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    headerLabel.textColor=[UIColor whiteColor];
    NSString *  personname;
    personname= [mainmenuArray objectAtIndex:section];
    headerLabel.text=personname;
    headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    headerLabel.numberOfLines = 0;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [sectionHeaderView addSubview:headerLabel];

    UILabel  * line=[[UILabel alloc] initWithFrame:CGRectMake(0,49,tableView.frame.size.width,1)];
    [line setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
    [sectionHeaderView addSubview:line];

    BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];
    
    UIImageView *dashboardImage=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width-90,15,20,20)];
    
    if (section!=0 && section!=1 && section!=4 && section!=5 && section!=6 ) {
    if (!manyCells) {
        [dashboardImage setImage:[UIImage imageNamed:@"down_arrow.png"]];
        
    }else{
        [dashboardImage setImage:[UIImage imageNamed:@"up_arrow.png"]];
    }
    [sectionHeaderView addSubview:dashboardImage];
    }
    if (section==0 || section==1 || section==4 ) {
    UIButton *countLbl=[[UIButton alloc]initWithFrame:CGRectMake(tableView.frame.size.width-100,5,40,40)];
        if (section==1 ){
            if (appDelegate.msgTotalCount>0) {
                [countLbl setTitle:[NSString stringWithFormat:@"%d",appDelegate.msgTotalCount] forState:UIControlStateNormal];
                [countLbl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                countLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [countLbl setBackgroundImage:[UIImage imageNamed:@"circle_blue.png"] forState:UIControlStateNormal];
                UIFont * font =[UIFont fontWithName:@"Open Sans" size:9.0f];
                countLbl.titleLabel.font = font;
                [sectionHeaderView addSubview:countLbl];

            }else{
               // [countLbl setTitle:@"0" forState:UIControlStateNormal];
            }
        }else{
            //[countLbl setTitle:@"0" forState:UIControlStateNormal];
        }
    }
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionHeaderView addGestureRecognizer:headerTapped];
    sectionHeaderView.tag= section;
    return sectionHeaderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    int height=50;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        if ( indexPath == selectedIndexPath)
        {
            if (issubjectexpand) {
                int height=screenRect.size.height*0.30;
                return height;
            }else{
                int height=screenRect.size.height*0.20;
                return height;
            }
        }
        else
        {
        int height=screenRect.size.height*0.10;
        return height;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    BOOL manyCells= [[arrayForBool objectAtIndex:section] boolValue];
    if (!manyCells) {
        [footer setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"invoicelistitem.PNG"]]];
    }else{
        [footer setBackgroundColor:[UIColor clearColor]];
    }
    return footer;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *NameLbl;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.textLabel.textColor=[UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    if (!manyCells) {
        // cell.textLabel.text = @"click to enlarge";
    }
    else{
        NSString *  personname;
        personname= [mainmenuArray objectAtIndex:indexPath.section];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mainMenu = %@", personname];
        NSArray *filterArray = [submenuArray filteredArrayUsingPredicate:predicate];
        
        MenuVO * contactVOs=[filterArray objectAtIndex:indexPath.row];
        NameLbl=[[UILabel alloc] initWithFrame:CGRectMake(12, 0, screenRect.size.width*0.45,screenRect.size.height*0.10)];
        
        NameLbl.font = [UIFont fontWithName:@"Open Sans" size:14];
        NameLbl.textColor=[UIColor blackColor];
        NameLbl.text=contactVOs.submenu;
        NameLbl.textAlignment = NSTextAlignmentLeft;
        NameLbl.lineBreakMode = NSLineBreakByWordWrapping;
        NameLbl.numberOfLines = 0;
        [cell.contentView addSubview:NameLbl];
        
//        if (indexPath.row==0 && indexPath.section==2) {
//            [indexImage removeFromSuperview];
//            indexImage=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width-90,15,20,20)];
//            [indexImage setImage:[UIImage imageNamed:@"open_angle_red_.png"]];
//            [cell.contentView addSubview:indexImage];
//        }
//        
//        if (indexPath.row==1 && indexPath.section==2) {
//            [indeximage1 removeFromSuperview];
//            indeximage1=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width-90,15,20,20)];
//            [indeximage1 setImage:[UIImage imageNamed:@"open_angle_red_.png"]];
//            [cell.contentView addSubview:indeximage1];
//        }
//        if (isvisible) {
//            //[listofcourseBtn removeFromSuperview];
//            [indexImage setImage:[UIImage imageNamed:@"close_angle_red_.png"]];
//
//            listofcourseBtn=[[UIButton alloc] initWithFrame:CGRectMake(30,screenRect.size.height*0.11, screenRect.size.width*0.65, screenRect.size.height*0.08)];
//            listofcourseBtn.layer.cornerRadius = 6.0f;
//            [listofcourseBtn setTitle:@"Links of courses" forState:UIControlStateNormal];
//            [listofcourseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            listofcourseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//            [listofcourseBtn setBackgroundColor:[UIColor clearColor]];
//            [listofcourseBtn.titleLabel setFont:[UIFont fontWithName:@"Open Sans" size:14]];
//            [listofcourseBtn addTarget:self action:@selector(linkcourseAction:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:listofcourseBtn];
//            listofcourseBtn.tag=indexPath;
//            UILabel  * line=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.20-1, screenRect.size.width,1)];
//            [line setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
//            [cell.contentView addSubview:line];
//        }
//        if (issubjectvis) {
//            [indeximage1 setImage:[UIImage imageNamed:@"close_angle_red_.png"]];
//            
//            [subjectbtn removeFromSuperview];
//            subjectbtn=[[UIButton alloc] initWithFrame:CGRectMake(30,screenRect.size.height*0.11, screenRect.size.width*0.65, screenRect.size.height*0.08)];
//            subjectbtn.layer.cornerRadius = 6.0f;
//            [subjectbtn setTitle:@"Webinar" forState:UIControlStateNormal];
//            [subjectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            subjectbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//            [subjectbtn setBackgroundColor:[UIColor clearColor]];
//            [subjectbtn.titleLabel setFont:[UIFont fontWithName:@"Open Sans" size:14]];
//            [subjectbtn addTarget:self action:@selector(subjectAction:) forControlEvents:UIControlEventTouchUpInside];
//            subjectbtn.tag=indexPath;
//            [cell.contentView addSubview:subjectbtn];
//            
//            [indeximage2 removeFromSuperview];
//            indeximage2=[[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width-90,screenRect.size.height*0.13,20,20)];
//            [indeximage2 setImage:[UIImage imageNamed:@"open_angle_red_.png"]];
//           // [cell.contentView addSubview:indeximage2];
//
//            UILabel  * line=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.20-1, screenRect.size.width,1)];
//            [line setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
//            [cell.contentView addSubview:line];
//
//            if (issubjectexpand) {
//                [indeximage2 setImage:[UIImage imageNamed:@"close_angle_red_.png"]];
//                [datelocationBtn removeFromSuperview];
//                datelocationBtn=[[UIButton alloc] initWithFrame:CGRectMake(50,screenRect.size.height*0.21, screenRect.size.width*0.65, screenRect.size.height*0.08)];
//                datelocationBtn.layer.cornerRadius = 6.0f;
//                [datelocationBtn setTitle:@"Dates and Locations" forState:UIControlStateNormal];
//                [datelocationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                datelocationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//                [datelocationBtn setBackgroundColor:[UIColor clearColor]];
//                [datelocationBtn.titleLabel setFont:[UIFont fontWithName:@"Open Sans" size:14]];
//                [datelocationBtn addTarget:self action:@selector(datelocationAction:) forControlEvents:UIControlEventTouchUpInside];
//                datelocationBtn.tag=indexPath;
//                [cell.contentView addSubview:datelocationBtn];
//                
//                UILabel  * line=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.30-1, screenRect.size.width,1)];
//                [line setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
//                [cell.contentView addSubview:line];
//            }
//        }
        UILabel  * line=[[UILabel alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.10-1, screenRect.size.width,1)];
        [line setBackgroundColor:[UIColor colorWithHexString:@"923846"]];
        [cell.contentView addSubview:line];
        tableView.backgroundColor=[UIColor clearColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        for (int count=0; count<[arrayForBool count]; count++) {
            [arrayForBool replaceObjectAtIndex:count withObject:[NSNumber numberWithBool:NO]];
        }
        [_rearTableView reloadData];
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        //reload specific section animated
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.rearTableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
    
    if (indexPath.section==0) {
        NSLog( @"%ld: indexPath", (long)indexPath.section);
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=0;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

    }
    if (indexPath.section==1) {
        NSLog( @"%ld: indexPath", (long)indexPath.section);
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=1;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

    }

//    if (indexPath.section==3) {
//        NSLog( @"%ld: indexPath", (long)indexPath.section);
//        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//        appDelegate.index=0;
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
//        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
//        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
//
//    }
    if (indexPath.section==4) {
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=5;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

    }
    if (indexPath.section==5) {
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=14;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        
    }
    if (indexPath.section==6) {
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=6;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"%@: indexPath", indexPath);
    if (indexPath.row==0 && indexPath.section==2) {
//        isvisible=true;
//        issubjectvis=false;
//        selectedIndexPath = indexPath;
        
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=12;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

        
    }else if (indexPath.row==1 && indexPath.section==2){
        
//        selectedIndexPath = indexPath;
//        issubjectvis=true;
//        isvisible=false;
        
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=11;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

    }else if (indexPath.row==2 && indexPath.section==2){
        
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=13;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

    }else if (indexPath.row==3 && indexPath.section==2){
        
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=10;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        
    }
    if (indexPath.section==4) {
        MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        appDelegate.index=0;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
        navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
   
    }
        [_rearTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
    [_rearTableView reloadData];
}

-(void)linkcourseAction:(UIButton *)btn{
    NSLog( @"linkcourseAction");
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=12;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

}
-(void)subjectAction:(UIButton *)btn{
    NSLog( @"subjectAction");
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=11;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

//    UITableViewCell *projectcell=(UITableViewCell *)[btn superview];
//    NSIndexPath *indexPath = [_rearTableView indexPathForCell: projectcell.superview];
//    selectedIndexPath = indexPath;
//    issubjectvis=true;
//    issubjectexpand=true;
//    [_rearTableView reloadData];
    
    
}
-(void)datelocationAction:(UIButton *)btn{
    NSLog( @"datelocationAction");
    MainViewController *mainvc=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    appDelegate.index=0;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainvc];
    navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

}

@end
