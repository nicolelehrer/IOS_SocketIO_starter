//
//  ViewController.swift
//  SocketTacToe
//
//  Created by Nicole Lehrer on 7/28/15.
//  Copyright (c) 2015 Nicole Lehrer. All rights reserved.
//

import UIKit
import Socket_IO_Client_Swift


class ViewController: UIViewController {
    var resetAck:AckEmitter?
    var name:String?
    let socket = SocketIOClient(socketURL: "http://localhost:8900")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addHandlers()
        self.socket.connect()  //server side: this.io.sockets.on("connection", function(socket) {})
    }
    
    func addHandlers() {
        self.socket.on("welcome") {[weak self] data, ack in
            if let message = data?[0] as? String{
                self?.handleStart(message)
            }
        }
        
        self.socket.on("gameOver") {data, ack in
            exit(0)
        }
        
        self.socket.onAny {
            println("Got event: \($0.event), with items: \($0.items)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleStart(message:String?){
        print(message)
    }

    @IBAction func sendMessage(sender: AnyObject) {
        println("sending message to server")
        socket.emit("clientMessage", "welcome back at you", "your favorite client")
    }
    
    @IBAction func closeServer(sender: AnyObject) {
//        resetAck?(true)
    }
    
}

