//
//  ViewController.swift
//  ARGlowParticle
//
//  Created by Toshihiro Goto on 2019/01/08.
//  Copyright © 2019 Toshihiro Goto. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private var hdrCamera: SCNCamera!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "main.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        hdrCamera = sceneView.pointOfView?.camera
        hdrCamera.wantsHDR = true
        
        hdrCamera.exposureAdaptationBrighteningSpeedFactor = 0.4
        hdrCamera.exposureAdaptationDarkeningSpeedFactor = 0.6
        
        hdrCamera.wantsExposureAdaptation = true
        hdrCamera.minimumExposure = -15
        hdrCamera.maximumExposure = 15
        
        hdrCamera.bloomIntensity = 2.0
        hdrCamera.bloomThreshold = 0.6
        hdrCamera.bloomBlurRadius = 30
        
        hdrCamera.wantsDepthOfField = false
        hdrCamera.focalLength = 28
        hdrCamera.fStop = 1.2
        hdrCamera.focusDistance = 1.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // Select: Bloom Threshold
    @IBAction func selectBloomThreshold(_ sender: UISegmentedControl) {
        let threshold: CGFloat
        
        switch sender.selectedSegmentIndex {
        case 0:
            threshold = 1.4
        case 1:
            threshold = 0.6
        case 2:
            threshold = 0.2
        default:
            threshold = 0.6
        }
        
        hdrCamera.bloomThreshold = threshold
    }

    // Switch: Depth Of Field
    @IBAction func switchDOF(_ sender: UISwitch) {
        if ( sender.isOn ) {
            hdrCamera.wantsDepthOfField = true
        } else {
            hdrCamera.wantsDepthOfField = false
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
