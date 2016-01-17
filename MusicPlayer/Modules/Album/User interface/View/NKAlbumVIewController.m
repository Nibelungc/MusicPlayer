//
//  NKAlbumVIewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAlbumVIewController.h"
#import "NKAudioTrack.h"
#import "NKAudioTrackCell.h"
#import "NKPlayerView.h"

CGFloat const kPlayerViewHeight = 88.0;

@interface NKAlbumVIewController () <NKPlayerViewDelegate>

@property (weak, nonatomic) UITableView* tableView;

@property (weak, nonatomic) NKPlayerView* playerView;

@end

@implementation NKAlbumVIewController

@dynamic eventHandler;

#pragma mark - Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Configuration

- (void) configureView {
    [super configureView];
    
    CGRect tableViewFrame = self.view.bounds;
    UITableView* tableView = [[UITableView alloc] initWithFrame: tableViewFrame
                                                          style: UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview: tableView];
    self.tableView = tableView;

    
}

- (void) configurePlayerView: (NKPlayerView*) playerView {
    
    playerView.backgroundColor = [UIColor brownColor];
    playerView.delegate = self;
    [self.view addSubview: playerView];
    
    [playerView.playButton addTarget: self.eventHandler
                              action: @selector(playOrPauseAudio)
                    forControlEvents: UIControlEventTouchUpInside];
    
    [playerView.nextButton addTarget: self.eventHandler
                              action: @selector(playNextAudioTrack)
                    forControlEvents: UIControlEventTouchUpInside];
    
    [playerView.prevButton addTarget: self.eventHandler
                              action: @selector(playPreviousAudioTrack)
                    forControlEvents: UIControlEventTouchUpInside];
    
    self.playerView = playerView;
}

#pragma mark - NKAlbumView

- (void) setModuleTitle: (NSString*) title {
    self.navigationItem.title = title.uppercaseString;
}

- (void) showEmptyListOfAudioTracks {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void) presentPlayerView: (NKPlayerView*) playerView {
    [self configurePlayerView: playerView];
}


- (void) trackDidStartPlayingWithIndex: (NSInteger) index {
    [self.playerView showAnimated: YES];
    [self.tableView selectRowAtIndexPath: [self indexPathForIndex: index]
                                animated: YES
                          scrollPosition: UITableViewScrollPositionNone];
}

- (void) trackDidStopPlayingWithIndex: (NSInteger) index {
    [self.tableView deselectRowAtIndexPath: [self indexPathForIndex: index]
                                  animated: YES];
}

#pragma mark - Private

- (void) updateListOfAudioTracks: (NSArray <NKAudioTrack *>*) audioTracks {
    self.audioTracks = audioTracks;
    [self reloadData];
    [self.eventHandler albumWasLoaded];
    if (!self.playerView) {
        [self.eventHandler needToAddPlayerWithHeight: kPlayerViewHeight];
    }
}

- (void) reloadData {
    [self.tableView reloadData];
}

- (NKAudioTrack*) audioTrackForIndexPath: (NSIndexPath*) indexPath {
    if (indexPath.row >= 0 &&
        indexPath.row < self.audioTracks.count) {
        return self.audioTracks[indexPath.row];
    }
    return nil;
}

- (NSIndexPath*) indexPathForIndex: (NSInteger) index {
    return [NSIndexPath indexPathForRow: index inSection: 0];
}

#pragma mark - NKPlayerViewDelegate

- (void) playerViewDidShow: (nonnull NKPlayerView*) playerView animated: (BOOL) animated {
    UIEdgeInsets currentInset = self.tableView.contentInset;
    currentInset.bottom = CGRectGetHeight(playerView.bounds);
    self.tableView.contentInset = currentInset;
    self.tableView.scrollIndicatorInsets = currentInset;
}

- (void) playerViewDidHide: (nonnull NKPlayerView*) playerView animated: (BOOL) animated {
    UIEdgeInsets currentInset = self.tableView.contentInset;
    currentInset.bottom = 0.0;
    self.tableView.contentInset = currentInset;
    self.tableView.scrollIndicatorInsets = currentInset;
}

@end

#pragma mark - UITableViewDataSource

@implementation NKAlbumVIewController (TableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.audioTracks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NKAudioTrackCell* cell = [tableView dequeueReusableCellWithIdentifier: [NKAudioTrackCell reuseIdentifier]];
    if (!cell) {
        cell = [NKAudioTrackCell createCell];
    }
    NKAudioTrack* track = [self audioTrackForIndexPath: indexPath];
    [cell configureCellWithTrack: track];
    return cell;
}

@end

#pragma mark - UITableViewDelegate

@implementation NKAlbumVIewController (TableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NKAudioTrack* selectedTrack = [self audioTrackForIndexPath: indexPath];
    [self.eventHandler selectAudioTrackWithID: selectedTrack.identifier];
}

@end