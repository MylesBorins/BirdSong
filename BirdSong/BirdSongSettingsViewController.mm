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
@property (weak, nonatomic) IBOutlet UISlider *maxVelocitySlider;
@property (weak, nonatomic) IBOutlet UILabel *maxVelocityLabel;

@end

@implementation BirdSongSettingsViewController

- (void)viewDidLoad
{
    self.dampeningSlider.value = Globals::scaler;
    self.dampeningLabel.text = [NSString stringWithFormat:@"%f", Globals::scaler];
    
    self.maxVelocitySlider.value = Globals::boundVelocity;
    self.maxVelocityLabel.text = [NSString stringWithFormat:@"%f", Globals::boundVelocity];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    Globals::scaler = sender.value;
    self.dampeningLabel.text = [NSString stringWithFormat:@"%f", Globals::scaler];
}
- (IBAction)maxVelocitySliderChange:(UISlider *)sender {
    Globals::boundVelocity = sender.value;
    self.maxVelocityLabel.text =[NSString stringWithFormat:@"%f", Globals::boundVelocity];
}

@end
