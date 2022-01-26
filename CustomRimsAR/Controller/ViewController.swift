//
//  ViewController.swift
//  CustomRimsAR
//
//  Created by Robert Vesa on 17.01.2022.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var test : String = ""
    var detectionImage : UIImage?
    var rimName: String = ""
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(test)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
        
    }
    
    func loadDynamicImageReferences(){

        //1. Get The Image From The Folder
        guard let imageFromBundle = detectionImage,
        //2. Convert It To A CIImage
        let imageToCIImage = CIImage(image: imageFromBundle),
        //3. Then Convert The CIImage To A CGImage
        let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage)else { return }

        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.2)
    }

    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
         return cgImage
        }
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        guard let imageFromBundle = detectionImage,
        //2. Convert It To A CIImage
        let imageToCIImage = CIImage(image: imageFromBundle),
        //3. Then Convert The CIImage To A CGImage
        let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage)else { return }

        //4. Create An ARReference Image (Remembering Physical Width Is In Metres)
        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.065)
        
            
            configuration.detectionImages = [arImage]
            
            configuration.maximumNumberOfTrackedImages = 1
            
            print("images sucessfuly added")
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                 height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
        
                
            if let pokeScene = SCNScene(named: "art.scnassets/"+rimName+".scn"){
                
                if let pokeNode = pokeScene.rootNode.childNodes.first {
                    
                    
                    planeNode.addChildNode(pokeNode)
                }
            }
            
        }
        
        return node
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
