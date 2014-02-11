//
//  BirdSongSettingsViewController.m
//  BirdSong
//
//  Created by thealphanerd on 2/5/14.
//  Copyright (c) 2014 Ge Wang. All rights reserved.
//

#import "BirdSongSettingsViewController.h"
#import "Globals.h"

@interface BirdSongSettingsViewController()

@property (weak, nonatomic) IBOutlet UISlider *dampeningSlider;
@property (weak, nonatomic) IBOutlet UILabel *dampeningLabel;

@end

@implementation BirdSongSettingsViewController

- (void)viewDidLoad
{
//    self.dampeningSlider.value = Globals::damp;
//    self.dampeningLabel.text = [NSString stringWithFormat:@"%f", Globals::damp];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
//    Globals::damp = sender.value;
//    self.dampeningLabel.text = [NSString stringWithFormat:@"%f", Globals::damp];
}

@end
