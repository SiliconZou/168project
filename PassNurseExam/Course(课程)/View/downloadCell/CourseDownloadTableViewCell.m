//
//  CourseDownloadTableViewCell.m
//  PassNurseExam
//
//  Created by qc on 2019/9/19.
//  Copyright © 2019 ucmed. All rights reserved.
//

#import "CourseDownloadTableViewCell.h"
#import <CommonCrypto/CommonCrypto.h>
#import "CourseDownloadFileInfoModel.h"
#import "URLoadingIndicator.h"
#import "CourseDownloadFileInfoModel.h"

@interface CourseDownloadTableViewCell()<NSURLConnectionDelegate>


@end


@implementation CourseDownloadTableViewCell

- (void)setCurriculumsModel:(CourseCommonDetailDataCurriculumsModel *)curriculumsModel
{
    _curriculumsModel = curriculumsModel ;
    
    self.titleLabel.text = [NSString  stringWithFormat:@"%@",curriculumsModel.name?:@""] ;
    
    //  有的文件已经下载完毕或者下载了一部分，需要知道进度信息，调用此方法返回 已经存在文件的进度信息
    TaskProgressInfo *info = [[DownloadManager shareManager] progressInfoIfFileExsit:curriculumsModel.download_address];
    
    if (info)
    {
        if (info.progress >= 1)
        {
            _curriculumsModel.downloadStatus = TaskHasDownload;
        }
        else // 0~1 之间，已下载一部分
        {
            // 还未全部下载完，但停止下载了，将状态设为 暂停，等待恢复下载
            if (info.remainingLenth > 0 && info.taskDownloadStatus == TaskNotDownload)
            {
                _curriculumsModel.downloadStatus = TaskResumeDownload;
            } else
            {
                _curriculumsModel.downloadStatus = info.taskDownloadStatus;

                if (info.taskDownloadStatus != TaskNotDownload)
                {
                    @weakify(self);
                    
                    [[DownloadManager shareManager] download:[NSString stringWithFormat:@"%@",_curriculumsModel.download_address] model:_curriculumsModel progress:^(TaskProgressInfo *progressInfo) {
                        @strongify(self);
                        
                        if ([_curriculumsModel.download_address isEqualToString:progressInfo.url])
                        {
                            _curriculumsModel.downloadStatus = progressInfo.taskDownloadStatus;
                            [self setButtonStatus:progressInfo.progress];
                        }
                    } complete:^(NSString *filePath, NSError *error) {
                        
                    } enableBackgroundMode:YES];
                }
            }
        }
    } else
    {
        _curriculumsModel.downloadStatus = TaskNotDownload;
    }
    [self setButtonStatus:info.progress];
}
 
- (void)setButtonStatus:(float)progress
{
    switch (self.curriculumsModel.downloadStatus) {
            
        case TaskIsDownloading:// 蓝色
        {
            [self.downloadButton setTitle:[NSString stringWithFormat:@"%.f%%",progress * 100.0] forState:UIControlStateNormal];
            [self.downloadButton setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
            break;
        }
        case TaskWaitDownload:// 蓝色
        {
            [self.downloadButton setTitle:@"等待下载" forState:UIControlStateNormal];
            [self.downloadButton setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
            break;
        }
        case TaskHasDownload:// 绿色
        {
            [self.downloadButton setTitle:@"已下载" forState:UIControlStateNormal];
            [self.downloadButton setBackgroundColor:UR_ColorFromValue(0x4cdd8e)];

            [self getUrlFileLength:self.curriculumsModel.download_address];
            break;
        }
        case TaskResumeDownload:// 蓝色
        {
            [self.downloadButton setTitle:[NSString stringWithFormat:@"暂停%.f%%",progress * 100.0] forState:UIControlStateNormal];
            [self.downloadButton setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
            break;
        }
        case TaskNotDownload:// 本来是想用红色区分的 0xFF2A1A， 改回蓝色了
        {
            [self.downloadButton setTitle:@"未下载" forState:UIControlStateNormal];
            [self.downloadButton setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
            break;
        }
        default:{
            break;
        }
    }
}

- (IBAction)downloadButtonClick:(UIButton *)sender {
    
    
    if (self.curriculumsModel.vip.intValue==1)//会员课程
    {
        if ([URUserDefaults standardUserDefaults].userInforModel.is_vip.intValue == 0)//还不是会员
        {
            [URToastHelper showErrorWithStatus:@"这是会员专属课程，请先开通vip再进行下载"] ;
            return ;
        }
        //已经是会员
    } else
    {
        if (self.curriculumsModel.charge.intValue==1)//付费课程
        {
            if (self.curriculumsModel.own.intValue==0)//未购买
            {
               [URToastHelper showErrorWithStatus:@"请先购买该视频，再进行下载"] ;
               return ;
            }
            //已购买
        }
        //免费课程
    }
    
    switch (self.curriculumsModel.downloadStatus)
    {
        case TaskHasDownload:
        {
            if ([self.downloadButton.titleLabel.text hasPrefix:@"已更新"])
            {
                DownloadManager *manager = [DownloadManager shareManager];
                [manager removeHasDownloadTask:self.curriculumsModel.download_address];
                [self start];
            }
            else//播放
            {
                [URToastHelper showWithStatus:@"正在解析下载视频"];
                
                [[CourseDownloadFileInfoModel shareInstance] funcDeFile:self.curriculumsModel.download_address finishBlock:^(NSString *path) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [URToastHelper dismiss];
                    });
                    
                    if (self.bBackVideoBlock) {
                        self.bBackVideoBlock(path);
                    }
                }];
            }
            break;
        }
        case TaskResumeDownload://被暂停中  点击
        {
            [self resume];//恢复下载
            break;
        }
        case TaskNotDownload://未下载过 点击
        {
            if (self.net == 3) {
                [self alertA];//提示 是否流量下载
            }else{
                [self start];//开始下载
            }
            break;
        }
        case TaskIsDownloading://下载中 点击
        {
            [self pause];//暂停
            break;
        }
        case TaskWaitDownload://
        {
            [self.downloadButton setTitle:@"等待下载" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}

- (void)alertA
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否在非Wi-Fi下下载视频" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self start];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self.currentController presentViewController:alert animated:YES completion:nil];
    
}

/**
 *  从零开始
 */
- (void)start
{
    __weak __typeof(&*self)ws = self;
    [[DownloadManager shareManager] download:[NSString stringWithFormat:@"%@",self.curriculumsModel.download_address] model:self.curriculumsModel progress:^(TaskProgressInfo *progressInfo) {
        
        if ([ws.curriculumsModel.download_address isEqualToString:progressInfo.url])
        {
            ws.curriculumsModel.downloadStatus = progressInfo.taskDownloadStatus;
            [ws setButtonStatus:progressInfo.progress];
            
            if (progressInfo.progress >= 1)
            {
                //将已下载的视频信息 保存到 plist 文件里
                FileModel *model = [FileModel alloc];
                model.courseName = self.curriculumsModel.name;
                model.downloadUrl = self.curriculumsModel.download_address;
                model.playUrl = self.curriculumsModel.play_address;
                model.checkCode = self.curriculumsModel.md5;

                [[CourseDownloadFileInfoModel shareInstance] safeFileModel:model fileName:@"course"];
            }
        }
    } complete:^(NSString *filePath, NSError *error) {
        
    } enableBackgroundMode:YES];
}

/**
 *  恢复（继续）
 */
- (void)resume
{
    if (self.net == 3) {
        [self alertA];//提示 是否流量下载
    }else{
        [self start];//开始下载
    }
     
    //恢复其实没用到，还是用的 重新下载
//    [[DownloadManager shareManager] retryDownload:[NSString stringWithFormat:@"%@",self.curriculumsModel.download_address]];
}

/**
 *  暂停
 */
- (void)pause
{
    [[DownloadManager shareManager] cancleDownload:[NSString stringWithFormat:@"%@",self.curriculumsModel.download_address]];
    self.curriculumsModel.downloadStatus = TaskResumeDownload;
    
    TaskProgressInfo *info = [[DownloadManager shareManager] progressInfoIfFileExsit:self.curriculumsModel.download_address];

    [self setButtonStatus:info.progress];
}

//通过url获得网络的文件的大小 返回byte
- (void)getUrlFileLength:(NSString *)url
{
    NSMutableURLRequest *mURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [mURLRequest setHTTPMethod:@"HEAD"];
    mURLRequest.timeoutInterval = 5.0;
    NSURLConnection *URLConnection = [NSURLConnection connectionWithRequest:mURLRequest delegate:self];
    [URLConnection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //网络文件
    NSDictionary *dict = [(NSHTTPURLResponse *)response allHeaderFields];
    NSNumber *length = [dict objectForKey:@"Content-Length"];
    [connection cancel];
    [length longLongValue];
    // length单位是byte，除以1000后是KB（文件的大小计算好像都是1000，而不是1024），
    
    //本地文件
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[[CourseDownloadFileInfoModel shareInstance] getAseFileName:self.curriculumsModel.download_address]];
    
    NSData *dataEncoded = [NSData dataWithContentsOfFile:filePath];
    
    if (dataEncoded.length == [length longLongValue]) {
        
    }else{
        [self.downloadButton setTitle:@"已更新" forState:UIControlStateNormal];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.downloadButton setBackgroundColor:UR_ColorFromValue(0x63A3FF)];
    self.downloadButton.layer.cornerRadius = 15.0f ;
    self.downloadButton.layer.masksToBounds = YES ;
    
    //监听网络状态
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                self.net = 404;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.net = 2;
                break;
            default:
                self.net = 3;
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
