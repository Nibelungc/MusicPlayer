//
//  NKAlbumVIewController.h
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKBaseViewController.h"

#import "NKAlbumView.h"
#import "NKAlbumModule.h"

@interface NKAlbumVIewController : NKBaseViewController <NKAlbumView>

@property (weak, nonatomic) id<NKAlbumModule> eventHandler;

@property (strong, nonatomic) NSArray* audioTracks;

@end


@interface NKAlbumVIewController (TableViewDataSource) <UITableViewDataSource>

@end


@interface NKAlbumVIewController (TableViewDelegate) <UITableViewDelegate>

@end