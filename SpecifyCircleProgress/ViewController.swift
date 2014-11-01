//
//  ViewController.swift
//  SpecifyCircleProgress
//
//  Created by wangzzh on 14/11/1.
//  Copyright (c) 2014年 wangzzh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HATransparentViewDelegate,CircularProgressViewDelegate {

    var transparentView=HATransparentView()
    var progressView=CircularProgressView()
    var progressLbl=UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor=UIColor.whiteColor()
        self.title="环形进度条"
        transparentView.delegate=self;
        self.view.addSubview(transparentView)

        var progressViewBg=UIView(frame:CGRectMake(10, self.view.frame.size.height/3-25, self.view.frame.size.width-20, self.view.frame.size.height/3+30))
        progressViewBg.backgroundColor=UIColor.whiteColor()
        progressViewBg.layer.cornerRadius=6

        transparentView.addSubview(progressViewBg)
        progressView.backgroundColor=UIColor.clearColor()
        progressView.lineWidth = 18
        progressView.backColor = UIColor.whiteColor()
        progressView.progressColor = UIColor(red: 102/255.0, green: 213/255.0, blue: 149/255.0, alpha: 1.0)
        progressView.delegate=self;
        progressView.frame=CGRectMake((self.view.frame.size.width-150)/2, 30, 150, 150)
        progressViewBg.addSubview(progressView)
        

        progressLbl.frame=CGRectMake(40, 40, 80, 80)
        progressLbl.text="80%"
        progressLbl.textAlignment=NSTextAlignment.Center
        progressLbl.font=UIFont.systemFontOfSize(22)
        progressLbl.textColor=UIColor(red: 41/255.0, green: 179/255.0, blue: 154/255.0, alpha: 1.0)
        progressView.addSubview(progressLbl);
        
        
        var noticelbl=UILabel(frame: CGRectMake(0, self.view.frame.size.height/3-5, self.view.frame.size.width-20, 20))
        noticelbl.textAlignment=NSTextAlignment.Center;
        noticelbl.textColor=UIColor(red: 41/255.0, green: 179/255.0, blue: 154/255.0, alpha: 1.0)
        noticelbl.font=UIFont.systemFontOfSize(18)
        noticelbl.text="努力分析中~ ~ ~";
        progressViewBg.addSubview(noticelbl)

        var submitBtn: UIButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        submitBtn.frame=CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height/3*2+50, 100, 40)
        submitBtn.setTitle("测试按钮", forState: UIControlState.Normal)
        submitBtn.backgroundColor=UIColor(red: 102/255.0, green: 213/255.0, blue: 149/255.0, alpha: 1.0)
        self.view.addSubview(submitBtn)

        submitBtn.addTarget(self, action: "submitBtnPressed", forControlEvents: UIControlEvents.TouchUpInside)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func  submitBtnPressed(){
        transparentView.open()
        self.progressView.play()
        self.progressView.playOrPauseButtonIsPlaying = true;
    }
    
    //实现CircularProgressViewDelegate
    func updateProgressView(var progressStr:String)
    {
        var value:Double=(progressStr as NSString).doubleValue
        progressLbl.text="\(value*100)%"
    }
    
    func progressDidFinish()
    {
        print("finish")
        transparentView.close()
    }
    
    //实现HATransparentViewDelegate
    func HATransparentViewDidClosed()
    {
        
    }

}

