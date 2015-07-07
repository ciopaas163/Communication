//
//  RegistrationController.m
//  Communication
//
//  Created by CIO on 15/1/28.
//  Copyright (c) 2015年 JL. All rights reserved.
//

#import "RegistrationController.h"
#import <QuartzCore/QuartzCore.h>
#import "SGInfoAlert.h"
#define LABLEWIDTH 80
#define LABLEHEIGHT 30
#define KSCREENWIDTH  [[UIScreen mainScreen] bounds].size.width
#define KSCRENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface RegistrationController ()<UITextFieldDelegate,NSURLConnectionDataDelegate>
{
    UITextField *numtextfield;
    UITextField *testtextfield;
    UITextField *passwordtextfield;
    UITextField *againpasswordtextfield;
    NSMutableData *data_;
    UIButton *yanButton;
}
@end

@implementation RegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    data_ = [[NSMutableData alloc]init];

    self.view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人注册";
    NSArray *lableArray = [NSArray arrayWithObjects:@"手机号",@"验证码",@"密码",@"确认密码", nil];

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonClick)];


    for (NSInteger i=0; i<4; i++)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(KSCREENWIDTH/8-10,100+i*LABLEHEIGHT*2,LABLEWIDTH,LABLEHEIGHT)];
        [lable setText:lableArray[i]];
        lable.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:lable];

    }

    numtextfield = [[UITextField alloc]initWithFrame:CGRectMake(KSCREENWIDTH/8+LABLEWIDTH, 100,KSCREENWIDTH-(KSCREENWIDTH/8-10)-(KSCREENWIDTH/8+LABLEWIDTH), LABLEHEIGHT)];
    numtextfield.backgroundColor = [UIColor whiteColor];
    numtextfield.delegate = self;
    numtextfield.tag = 1;
    numtextfield.keyboardType = UIKeyboardTypeNumberPad;
    numtextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    numtextfield.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
    numtextfield.layer.borderWidth = 1.0f;
    [self.view addSubview:numtextfield];

    [numtextfield becomeFirstResponder];
    //    numtextfield.layer.borderColor = [[UIColor orangeColor]CGColor];
    //    numtextfield.layer.borderWidth = 2.0f;

    testtextfield = [[UITextField alloc]initWithFrame:CGRectMake(KSCREENWIDTH/8+LABLEWIDTH, 100+LABLEHEIGHT*2,KSCREENWIDTH-(KSCREENWIDTH/8-10)-(KSCREENWIDTH/8+LABLEWIDTH)-80, LABLEHEIGHT)];
    testtextfield.backgroundColor = [UIColor whiteColor];
    testtextfield.delegate = self;
    testtextfield.tag = 2;
    testtextfield.keyboardType = UIKeyboardTypeNumberPad;
    testtextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    testtextfield.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
    testtextfield.layer.borderWidth = 1.0f;
    [self.view addSubview:testtextfield];

    CGFloat textX = CGRectGetMaxX(testtextfield.bounds);
    yanButton = [[UIButton alloc]initWithFrame:CGRectMake(KSCREENWIDTH/8+LABLEWIDTH+textX+5, 100+LABLEHEIGHT*2,75, LABLEHEIGHT)];
    yanButton.layer.cornerRadius = 5.0f;
    [yanButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    yanButton.titleLabel.font = [UIFont systemFontOfSize:13];
    yanButton.backgroundColor = [UIColor orangeColor];
    [yanButton addTarget:self action:@selector(useYanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yanButton];



    passwordtextfield = [[UITextField alloc]initWithFrame:CGRectMake(KSCREENWIDTH/8+LABLEWIDTH, 100+LABLEHEIGHT*2*2,KSCREENWIDTH-(KSCREENWIDTH/8-10)-(KSCREENWIDTH/8+LABLEWIDTH), LABLEHEIGHT)];
    passwordtextfield.backgroundColor = [UIColor whiteColor];
    passwordtextfield.delegate = self;
    passwordtextfield.tag = 3;
    passwordtextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordtextfield.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
    passwordtextfield.layer.borderWidth = 1.0f;
    [self.view addSubview:passwordtextfield];

    againpasswordtextfield = [[UITextField alloc]initWithFrame:CGRectMake(KSCREENWIDTH/8+LABLEWIDTH, 100+LABLEHEIGHT*2*3, KSCREENWIDTH-(KSCREENWIDTH/8-10)-(KSCREENWIDTH/8+LABLEWIDTH), LABLEHEIGHT)];
    againpasswordtextfield.backgroundColor = [UIColor whiteColor];
    againpasswordtextfield.delegate = self;
    againpasswordtextfield.tag = 4;
    againpasswordtextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    againpasswordtextfield.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
    againpasswordtextfield.layer.borderWidth = 1.0f;
    [self.view addSubview:againpasswordtextfield];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(useTapGuesturerecognizer)];
    [self.view addGestureRecognizer:tap];

    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(KSCREENWIDTH/8+10, 100+LABLEHEIGHT*2*4,KSCREENWIDTH-(KSCREENWIDTH/8+10)*2, LABLEHEIGHT+5)];
    registerButton.layer.cornerRadius =5.0f;
    [registerButton setTitle:@"完成注册" forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:141.0/255.0 blue:207.0/255.0 alpha:1];
    registerButton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    textField.layer.borderWidth = 2.0f;
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
    textField.layer.borderWidth = 1.0f;

    if(textField ==numtextfield && numtextfield.text.length !=11)
    {
        [SGInfoAlert showInfo:@"请输入正确的手机号"

                      bgColor: [UIColor orangeColor].CGColor

                       inView:self.view

                     vertical:0.8];
        return YES;
    }
    if (textField ==passwordtextfield && passwordtextfield.text.length <6) {
        [SGInfoAlert showInfo:@"密码不能少于6位"

                      bgColor: [UIColor orangeColor].CGColor

                       inView:self.view

                     vertical:0.8];
        return YES;
    }

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [numtextfield resignFirstResponder];
    [testtextfield resignFirstResponder];
    [passwordtextfield resignFirstResponder];
    [againpasswordtextfield resignFirstResponder];
    return YES;
}

-(void)useTapGuesturerecognizer
{
    [self.view endEditing:YES];
}


-(void)registerButtonClick
{
    [numtextfield resignFirstResponder];
    [testtextfield resignFirstResponder];
    [passwordtextfield resignFirstResponder];
    [againpasswordtextfield resignFirstResponder];

    NSString  *nsdic = [NSString stringWithFormat:@"{\"DataList\":[{\"code\":%@,\"phone\":%@,\"verify\":%@}]}",passwordtextfield.text,numtextfield.text,testtextfield.text];
    NSString *data = [nsdic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *str =[NSString stringWithFormat:@"http://open.ciopaas.com/Admin/Info/ad_personregister?registerdata=%@",data];
    NSLog(@" str = %@",str);
    [self userequest:str];

}

#pragma mark 短信验证事件
-(void)useYanButtonClick
{
    [numtextfield resignFirstResponder];
    [testtextfield resignFirstResponder];
    [passwordtextfield resignFirstResponder];
    [againpasswordtextfield resignFirstResponder];

    if(numtextfield.text.length !=11)
    {
        [SGInfoAlert showInfo:@"请输入正确的手机号"

                      bgColor: [UIColor orangeColor].CGColor

                       inView:self.view

                     vertical:0.8];
        return;
    }
    NSLog(@"num = %@",numtextfield.text);
    NSString *str = [NSString stringWithFormat:@"http://open.ciopaas.com/Admin/Info/SendVerify?message＝%@&request_type=1",numtextfield.text];
    
    NSLog(@"num = %@",str);
    
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]; //将请求的url数据放到NSData对象中
    NSError *error;
    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];

    NSLog(@"array-%@",array);

    NSString *resultw =[NSString stringWithFormat:@"%@",[array objectForKey:@"feed_message"]];
    NSString *resulterr = @"1";

    if([resultw isEqualToString:resulterr])
    {
        [self startTime];
    }
    else
    {
        [SGInfoAlert showInfo:@"请输入正确的手机号"

                      bgColor: [UIColor orangeColor].CGColor

                       inView:self.view

                     vertical:0.8];
    }
}

#pragma mark 短信验证记时
-(void)startTime
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [yanButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                yanButton.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [yanButton setTitle:[NSString stringWithFormat:@"重新获取(%@)",strTime] forState:UIControlStateNormal];
                yanButton.userInteractionEnabled = NO;

            });
            timeout--;

        }
    });
    dispatch_resume(_timer);

}


-(void)userequest:(NSString *)str
{

    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];

}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data_.length = 0;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [data_ appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data_ options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"array-%@",array);
    NSString *resultw =[NSString stringWithFormat:@"%@",[array objectForKey:@"register_result"]];
    NSString *resulterr = @"1";
    
//    [MBProgressHUD hideAllHUDsForView:self.contentScrollView animated:YES];
    if([resultw isEqualToString:resulterr])
    {
        
        [SGInfoAlert showInfo:@"注册成功"
         
                      bgColor: [UIColor orangeColor].CGColor
         
                       inView:self.view
         
                     vertical:0.8];
    }
    else
    {
        [SGInfoAlert showInfo:@"注册失败"
         
                      bgColor: [UIColor orangeColor].CGColor
         
                       inView:self.view
         
                     vertical:0.8];
    }
}

-(void)backButtonClick
{
    [numtextfield resignFirstResponder];
    [testtextfield resignFirstResponder];
    [passwordtextfield resignFirstResponder];
    [againpasswordtextfield resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
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
