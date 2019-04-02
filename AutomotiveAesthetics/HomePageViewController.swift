//
//  HomePageViewController.swift
//  AutomotiveAesthetics
//
//  Created by Kevin Rama on 3/12/19.
//  Copyright © 2019 Kevin Rama. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    
    let images: [UIImage] = [
        UIImage(named: "aaBMW")!,
        UIImage(named: "GTR")!,
        UIImage(named: "audi")!,
        UIImage(named: "car")!
    ]
    
    let labels = ["Who We Are", "Our Mission", "Why Us", "Our Services"];
    
    let text = [
        "This company was created with the goal of amplifying the value consumers place on how their vehicles look. We do not aim to acquire as many customers as possible, but rather to establish an ongoing relationship with those who love seeing their cars shine as much as we do.",
        
        "At Automotive Aesthetics, a customer's convenience is always our number one priority. Alongside the professional services we bring right to your doorstep at an incredible price, we also offer refunds for the rare occasion in which a customer is not satisfied with our work.",
        
        "Being completely mobile is our forte, allowing us to cater to our customer's desire of convenience. More often than not, people usually do not have the time to bring out their car to a shop. Through being mobile, we are able to adhere to our main priority of complete customer satisfaction.",
        
        
        "Basic Interior: Vacuum & Declutter, Blow out Vents, Crevices, & Gauges, Thorough wipe down of all interior components and door jams, Dressing of all plastic/vinyl\n\nBasic Exterior: Complete Foam Spray Down, Wash All Dirt & Grime, Polish Windows In & Out, Shine Tires\n\nDeluxe Interior: Vacuum & Declutter, Blow out Vents, Crevices, & Gauges, Thorough wipe down of all interior components and door jams, Dressing of all plastic/vinyl, Shampoo and Extract Carpets, Mats & Cloth Seats, Pre-Treat and Remove Most Stains, Sanitize and Clean All Surfaces with High-Pressure Steam, Clean & Condition All Leather, Protect and Shine Plastic & Vinyl, Air freshener\n\nDeluxe Exterior: Complete Foam Spray Down, Wash All Dirt & Grime, Deep Wheel Cleaning, Clay Bar Entire Car, Polish Windows In & Out, Shine Tires, Wax Applied\n\nBasic In and Out: Vacuum & Declutter, Blow Out All Vents, Crevices, & Gauges, Full Interior Cleaning of Console, Cup Holders, Door Panels, Dash, and Rubber Mats, Complete Foam Spray Down, Wash All Dirt & Grime, Polish Windows In & Out, Shine Tires\n\nDeluxe In and Out: Shampoo and Extract Carpets, Mats & Cloth Seats, Pre-Treat and Remove Most Stains, Sanitize and Clean All Surfaces with High-Pressure Steam, Clean & Condition All Leather, Protect and Shine Plastic & Vinyl, Air freshener, Complete Foam Spray Down, Wash All Dirt & Grime, Deep Wheel Cleaning, Clay Bar Entire Car, Polish Windows In & Out, Shine Tires, Wax Applied\n\nOdor Removal: Remove any lingering odors\n\nHeadlight Restoration: Remove the foggy haze from your headlights to get them looking like new"
    
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as! CollectionViewCell;
        
        cell.headerLabels.text = labels[indexPath.item];
        cell.images.image = images[indexPath.item];
        cell.largeText.text = text[indexPath.item];
        
        return cell;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self;
        homeCollectionView.dataSource = self;
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
