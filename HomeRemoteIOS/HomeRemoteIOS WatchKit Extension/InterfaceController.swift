//
//  InterfaceController.swift
//  HomeRemoteIOS WatchKit Extension
//
//  Created by Wouter Verweirder on 03/05/15.
//  Copyright (c) 2015 Wouter Verweirder. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    let urlRoot = "http://192.168.1.70:8888";

    @IBAction func mediaBackPressed() {
        executeButtonAction("xbmc", remoteKey: "Input.Back");
    }
    @IBAction func mediaUpPressed() {
        executeButtonAction("xbmc", remoteKey: "Input.Up");
    }
    @IBAction func mediaContextPressed() {
        executeButtonAction("xbmc", remoteKey: "Input.ContextMenu");
    }
    @IBAction func mediaLeftPressed() {
        executeButtonAction("xbmc", remoteKey: "Input.Left");
    }
    @IBAction func mediaOkPressed() {
        executeButtonAction("xbmc", remoteKey: "Input.Select");
    }
    @IBAction func mediaRightPressed() {
        executeButtonAction("xbmc", remoteKey: "Input.Right");
    }
    @IBAction func mediaPlayPausePressed() {
        executeButtonAction("xbmc", remoteKey: "Player.PlayPause");
    }
    @IBAction func mediaDownPressed() {
        executeButtonAction("xbmc", remoteKey: "Input.Down");
    }
    @IBAction func mediaStopPressed() {
        executeButtonAction("xbmc", remoteKey: "Player.Stop");
    }
    @IBAction func ampVolumeDownPressed() {
        executeButtonAction("samsung", remoteKey: "KEY_VOLUMEDOWN");
    }
    @IBAction func ampVolumeUpPressed() {
        executeButtonAction("samsung", remoteKey: "KEY_VOLUMEUP");
    }
    @IBAction func ampSrcPressed() {
        executeButtonAction("samsung", remoteKey: "KEY_CHANNEL");
    }
    @IBAction func ampVolumeMutePressed() {
        executeButtonAction("samsung", remoteKey: "KEY_MUTE");
    }
    @IBAction func tvPreviousPressed() {
        executeButtonAction("tv", remoteKey: "KEY_CHANNELDOWN");
    }
    @IBAction func tvNextPressed() {
        executeButtonAction("tv", remoteKey: "KEY_CHANNELUP");
    }
    @IBAction func ampPowerPressed() {
        executeButtonAction("samsung", remoteKey: "KEY_POWER");
    }
    @IBAction func tvPowerPressed() {
        executeButtonAction("tv", remoteKey: "KEY_POWER");
    }
    
    func executeButtonAction(remoteName:String, remoteKey:String) {
        //url: '/remote/' + $(this).data('remote-name') + '/' + $(this).data('remote-key')}
        let url = NSURL(string: urlRoot + "/remote/" + remoteName + "/" + remoteKey);
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding));
        }
        
        task.resume();
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
