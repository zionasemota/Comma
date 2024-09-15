//
//  ViewController.swift
//  Comma
//
//  Created by Period Sis. on 3/4/21.
//

import UIKit
import AVFoundation
import Vision
import MediaPlayer
import AVKit
import PTCardTabBar
import ASIACheckmarkView
import FirebaseDatabase
import FirebaseAuth

class ProductRecognitionVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate, UITableViewDelegate, UITableViewDataSource{
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        setCaptureSession()
        
        
        
       
        configureUI()
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    var photoOutput = AVCapturePhotoOutput()
        
    private lazy var headerView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "header")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
        
    }()
    
    private lazy var backBlurView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        mainView.layer.masksToBounds = true
        mainView.isHidden = true
        return mainView
        
    }()
    
    private lazy var listOfItemsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "list-icon"), for: .normal)
        button.addTarget(self, action: #selector(setupListOfItems), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var addItemView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        mainView.backgroundColor = .primaryRed
        mainView.layer.masksToBounds = false
        return mainView
        
    }()
    
    private lazy var checkmark: ASIACheckmarkView = {
       let checkmark = ASIACheckmarkView()
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        checkmark.lineColorForFalse = .white
        checkmark.checked = false
        checkmark.lineColorForTrue = .white
        
        return checkmark
        
    }()
    
    private lazy var addItemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Add To Supplies", for: .normal)
        button.titleLabel?.font = .poppins10Reg
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(addSupplyToList), for: .touchUpInside)
        
        return button
        
    }()
    
    @objc func addSupplyToList() {
        
        if checkmark.checked != true {
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            changeState(checkmark)
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                
                guard let shot = snapshot.value as? [String: Any] else {return}
                
                let pads = shot["numOfPads"] as? Int
                let tamps = shot["numOfTamp"] as? Int
                let cups = shot["numOfCups"] as? Int
                let others = shot["numOfOthers"] as? Int
                
                let userRef = Database.database().reference().child("users").child(uid)
                
                switch self.resultLabel.text {
                
                case "A Pad":
                    
                    guard let newPads = pads else {return}
                    
                    
                    userRef.updateChildValues(["numOfPads": newPads + 1])
                    
                case "A Tampon":
                    
                    guard let newTamps = tamps else {return}
                    
                    userRef.updateChildValues(["numOfTamp": newTamps + 1])
                    
                case "A Menstrual Cup":
                    
                    guard let newCups = cups else {return}
                    
                    userRef.updateChildValues(["numOfCups": newCups + 1])
                    
                case "A Menstrual Disc":
                    
                    guard let others = others else {return}
                    
                    userRef.updateChildValues(["numOfOthers": others + 1])
                    
                default:
                    
                    print("There was an error updating the user's values.")
                    
                }
                
                
            }
            
        }
        
    }
    
    @objc func setupListOfItems() {
        
        if backBlurView.isHidden == false && dropdownItems.isHidden == false {
            
            backBlurView.isHidden = true
            dropdownItems.isHidden = true
            
        } else if backBlurView.isHidden == true && dropdownItems.isHidden == true {
            
            backBlurView.isHidden = false
            dropdownItems.isHidden = false
            
        }
        
        
        
    }
    
    private lazy var resultView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 3
        view.isHidden = true
        
        
        return view
        
        
        
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = .poppins18Reg
        label.textAlignment = .center
        return label
        
    }()
    
    private lazy var resultDescription: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .poppins14Reg
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var exitButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "exit out"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = 2
        button.addAction(UIAction(title: "exiting result", handler: { (_) in
            
            self.checkmark.animate(checked: false)
            self.resultView.isHidden = true
            
        }), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var dropdownItems: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 3
        view.isHidden = true
        
        
        return view
        
        
        
    }()
    
    private lazy var dropdownTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .poppins18Reg
        label.sizeToFit()
        label.text = "List of Products Included in the AI"
        return label
    }()
    
    private lazy var itemsTableView: UITableView = {
        let table = UITableView();
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(itemCell.self, forCellReuseIdentifier: "item")
        table.backgroundColor = .clear
        
        return table
        
    }()
    
    
    
    private lazy var shotButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "analyze-icon"), for: .normal)
        button.addTarget(self, action: #selector(captureMLSession), for: .touchUpInside)
        
        return button
        
    }()
    
    
    func changeState(_ sender: ASIACheckmarkView) {
        sender.animate(checked:!sender.boolValue)
    }
    
    
    
    
    func changeStateWithSpinning(_ sender: ASIACheckmarkView) {
        if !sender.isSpinning {
            sender.animate(checked:!sender.boolValue)
            sender.isSpinning = true
        }
        else {
            sender.isSpinning = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "item") as! itemCell
        
        let list = ["Pads", "Tampons", "Menstrual Cups", "Menstrual Discs"]
        
        cell.textLabel?.text = list[indexPath.row]
        
        cell.textLabel?.font = .poppins12Reg
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
    
        
        return cell
        
    }
    

    
    func setCaptureSession() {
            
        let captureSession = AVCaptureSession()
        
        
        let presentDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        
        if captureSession.canAddOutput(photoOutput) {
            
            captureSession.addOutput(photoOutput)
        }
        
        
        do {
            if let captureDevice = presentDevices.first {
                captureSession.addInput(try AVCaptureDeviceInput(device: captureDevice))
            }
        } catch {
            print(error.localizedDescription)
        }
        
        let captureForOutput = AVCaptureVideoDataOutput()
        captureSession.addOutput(captureForOutput)
        
        captureForOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()

    }
    
    @objc func captureMLSession() {
        
        
        let photoSettings = AVCapturePhotoSettings()
      
        
        if let firstAvailablePreviewPhotoPixelFormatTypes = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: firstAvailablePreviewPhotoPixelFormatTypes]
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
            
            
        }
   
    }

    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let data = photo.fileDataRepresentation(),
              let image =  UIImage(data: data)  else {
            return
        }
        
        
        if let sceneLabelStr = imageToPixelBuffer(forImage: image) {
            
            
            
            
            resultView.isHidden = false
            resultLabel.text = sceneLabelStr
            resultLabel.textColor = .darkGreen
            
            switch sceneLabelStr {
            
            case "A Pad":
                
                resultDescription.text = "What Is It?\nA menstrual hygiene product with absorbent material that is attached inside underwear.\n\nHow To Use It?\n1. Take the pad out of the wrapper. Save it for later as you will need it to dispose the pad later.\n2. Remove the back paper from the pad.\n3. Place the menstrual pad, centering it inside the underwear lining."
                
            case "A Tampon":
                
                resultDescription.text = "What Is It?\nA menstrual hygiene product that is inserted into the vagina during menstruation in order to absorb blood.\n\nHow To Use It?\n1. Take the tampon out of the wrapper.\n2. Get into a comfortable position for tampon placement. Some sit on the toilet to do this.\n3. Place the end of the tampon applicator into the opening of your vagina. \n4. Slide the outer tubing of the tampon into your vagina until your fingers reach your body.\n5. Now use the inner tube of the applicator to push the tampon inside your body ."
                
            case "A Menstrual Cup":
                
                resultDescription.text = "What Is It?\nA menstrual hygiene product that is shaped like a funnel and is inserted into the vagina for blood collection. \n\nHow To Use It?\n1. Wash your hands.\n2. Find a comfortable position for menstrual cup placement.\n3. Fold the cup in a c- shape.\n4. Keep it rolled up and guide it slowly into the vagina."
                
            case "A Menstrual Disc":
                
                resultDescription.text = "What Is It?\nA menstrual hygiene product that is a flexible disk inserted into the vagina to collect period blood. \n\nHow To Use It?\n1. Wash your hands.\n2. Find a comfortable position for menstrual cup placement.\n3. Fold the cup in a c- shape.\n4. Keep it rolled up and guide it slowly into the vagina."
                
            default:
                
                print("AI Analysis: There was an error. Please try again.")
            
            
            }
        }
        
        
    }
    
    
    func imageToPixelBuffer(forImage image: UIImage) -> String? {
        
        if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!) {
            
            guard let scene = try? PeriodPovertyModel().prediction(image: pixelBuffer) else {fatalError("Unexpected Runtime Error")}
            
            return scene.classLabel
        }
        
        return nil
    }
    
    
    private func configureUI() {
        

        view.addSubview(headerView)
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(listOfItemsButton)
        listOfItemsButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15).isActive = true
        listOfItemsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        listOfItemsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.09).isActive = true
        listOfItemsButton.heightAnchor.constraint(equalTo: listOfItemsButton.widthAnchor).isActive = true
        
        view.addSubview(backBlurView)
        backBlurView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backBlurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backBlurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backBlurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(dropdownItems)
        dropdownItems.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dropdownItems.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dropdownItems.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        dropdownItems.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32).isActive = true
        
        dropdownItems.addSubview(dropdownTitle)
        dropdownTitle.topAnchor.constraint(equalTo: dropdownItems.topAnchor, constant: 10).isActive = true
        dropdownTitle.centerXAnchor.constraint(equalTo: dropdownItems.centerXAnchor).isActive = true
        dropdownTitle.widthAnchor.constraint(equalTo: dropdownItems.widthAnchor, multiplier: 0.85).isActive = true
        
        dropdownItems.addSubview(itemsTableView)
        itemsTableView.topAnchor.constraint(equalTo: dropdownTitle.bottomAnchor, constant: 8).isActive = true
        itemsTableView.leadingAnchor.constraint(equalTo: dropdownItems.leadingAnchor).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo: dropdownItems.bottomAnchor).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: dropdownItems.trailingAnchor).isActive = true
        
        view.addSubview(resultView)
        resultView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        resultView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        resultView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
        
        resultView.addSubview(exitButton)
        exitButton.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 15).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -15).isActive = true
        exitButton.widthAnchor.constraint(equalTo: resultView.widthAnchor, multiplier: 0.08).isActive = true
        exitButton.heightAnchor.constraint(equalTo: exitButton.widthAnchor).isActive = true
        
        resultView.addSubview(resultLabel)
        resultLabel.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 10).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: resultView.centerXAnchor).isActive = true
        resultLabel.widthAnchor.constraint(equalTo: resultView.widthAnchor, multiplier: 0.85).isActive = true
        
        resultView.addSubview(addItemView)
        addItemView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -5).isActive = true
        addItemView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -10).isActive = true
        addItemView.heightAnchor.constraint(equalTo: resultView.heightAnchor, multiplier: 0.08).isActive = true
        
        addItemView.addSubview(addItemButton)
        addItemButton.topAnchor.constraint(equalTo: addItemView.topAnchor).isActive = true
        addItemButton.bottomAnchor.constraint(equalTo: addItemView.bottomAnchor).isActive = true
        addItemButton.trailingAnchor.constraint(equalTo: addItemView.trailingAnchor, constant: -2).isActive = true
        
        addItemView.addSubview(checkmark)
        checkmark.trailingAnchor.constraint(equalTo: addItemButton.leadingAnchor).isActive = true
//        checkmark.leadingAnchor.constraint(equalTo: addItemView.leadingAnchor).isActive = true
        checkmark.centerYAnchor.constraint(equalTo: addItemView.centerYAnchor).isActive = true
        checkmark.widthAnchor.constraint(equalTo: addItemView.widthAnchor, multiplier: 0.2).isActive = true
        checkmark.heightAnchor.constraint(equalTo: checkmark.widthAnchor).isActive = true
        
        addItemView.leadingAnchor.constraint(equalTo: checkmark.leadingAnchor, constant: -5).isActive = true
        
        resultView.addSubview(resultDescription)
        resultDescription.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 8).isActive = true
        resultDescription.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 10).isActive = true
        resultDescription.bottomAnchor.constraint(equalTo: addItemView.topAnchor, constant: -5).isActive = true
        resultDescription.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -2).isActive = true
        
        view.addSubview(shotButton)
        shotButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        shotButton.heightAnchor.constraint(equalTo: shotButton.widthAnchor).isActive = true
        shotButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        shotButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        
        
    }
    

    

}



