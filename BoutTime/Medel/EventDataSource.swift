//
//  EventDataSource.swift
//  BoutTime
//
//  Created by Gavin Butler on 19-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct EventDataSource {
    
    static var events:[Event] = [   //variable to allow shuffling
        //  Attribution: https://www.livescience.com/33316-top-10-deadliest-natural-disasters.html
        Event(title: "Aleppo earthquake", year: 1138, url: "https://en.wikipedia.org/wiki/1138_Aleppo_earthquake"),
        Event(title: "Haiti earthquake", year: 2010, url: "https://en.wikipedia.org/wiki/2010_Haiti_earthquake"),
        Event(title: "Indian Ocean earthquake and tsunami", year: 2004, url: "https://en.wikipedia.org/wiki/2004_Indian_Ocean_earthquake_and_tsunami"),
        Event(title: "Haiyuan earthquake", year: 1920, url: "https://en.wikipedia.org/wiki/1920_Haiyuan_earthquake"),
        Event(title: "Tangshan earthquake", year: 1976, url: "https://en.wikipedia.org/wiki/1976_Tangshan_earthquake"),
        Event(title: "Antioch earthquake", year: 526, url: "https://en.wikipedia.org/wiki/526_Antioch_earthquake"),
        Event(title: "East India cyclone", year: 1839, url: "https://en.wikipedia.org/wiki/Coringa,_East_Godavari_district"),
        Event(title: "Haiphong typhoon", year: 1881, url: "https://en.wikipedia.org/wiki/1881_Haiphong_typhoon"),
        Event(title: "Bhola cyclone", year: 1970, url: "https://en.wikipedia.org/wiki/1970_Bhola_cyclone"),
        Event(title: "Shaanxi earthquake", year: 1556, url: "https://en.wikipedia.org/wiki/1556_Shaanxi_earthquake"),
        Event(title: "Yellow River Flood", year: 1887, url: "https://en.wikipedia.org/wiki/1887_Yellow_River_flood"),
        Event(title: "Central China Floods", year: 1931, url: "https://en.wikipedia.org/wiki/1931_China_floods"),
        
        //  Attribution: https://www.britannica.com/event/
        Event(title: "Al-Qaeda attacks on World Trade Centre, NYC", year: 2011, url: "https://en.wikipedia.org/wiki/September_11_attacks"),
        Event(title: "Sinking of the Titanic", year: 1912, url: "https://en.wikipedia.org/wiki/Sinking_of_the_RMS_Titanic"),
        Event(title: "Chernobyl Nuclear Accident", year: 1986, url: "https://en.wikipedia.org/wiki/Chernobyl_disaster"),
        Event(title: "Mount Vesuvius", year: 79, url: "https://en.wikipedia.org/wiki/Mount_Vesuvius"),
        Event(title: "Malaysia Airlines flight 370 disappearance", year: 2014, url: "https://en.wikipedia.org/wiki/Malaysia_Airlines_Flight_370"),
        Event(title: "Space Shuttle Challenger disaster", year: 1986, url: "https://en.wikipedia.org/wiki/Space_Shuttle_Challenger_disaster"),
        Event(title: "Hurricane Katrina", year: 2005, url: "https://en.wikipedia.org/wiki/Hurricane_Katrina"),
        Event(title: "Bhopal Chemical Leak", year: 1984, url: "https://en.wikipedia.org/wiki/Bhopal_disaster"),
        Event(title: "Nepal earthquake", year: 2015, url: "https://en.wikipedia.org/wiki/April_2015_Nepal_earthquake"),
        Event(title: "Fukushima Nuclear accident", year: 2011, url: "https://en.wikipedia.org/wiki/Fukushima_Daiichi_nuclear_disaster"),
        Event(title: "Columbia Space Shuttle", year: 2003, url: "https://en.wikipedia.org/wiki/Space_Shuttle_Columbia"),
        Event(title: "Japan (Tōhoku) earthquake and tsunami", year: 2011, url: "https://en.wikipedia.org/wiki/2011_T%C5%8Dhoku_earthquake_and_tsunami"),
        Event(title: "Halifax explosion", year: 1917, url: "https://en.wikipedia.org/wiki/Halifax_Explosion"),
        Event(title: "Mount Saint Helens eruption", year: 1980, url: "https://en.wikipedia.org/wiki/Mount_St._Helens"),
        Event(title: "Deepwater Horizon oil spill", year: 2010, url: "https://en.wikipedia.org/wiki/Deepwater_Horizon_oil_spill"),
        Event(title: "Lusitania Sinking", year: 1915, url: "https://en.wikipedia.org/wiki/Sinking_of_the_RMS_Lusitania"),
        Event(title: "Haiti earthquake", year: 2010, url: "https://en.wikipedia.org/wiki/2010_Haiti_earthquake"),
        Event(title: "Great Fire of London", year: 1666, url: "https://en.wikipedia.org/wiki/Great_Fire_of_London"),
        Event(title: "San Francisco earthquake", year: 1906, url: "https://en.wikipedia.org/wiki/1906_San_Francisco_earthquake"),
        Event(title: "Hurricane Sandy", year: 2012, url: "https://en.wikipedia.org/wiki/Hurricane_Sandy"),
        Event(title: "Season 8, Game of Thrones", year: 2019, url: "https://en.wikipedia.org/wiki/Game_of_Thrones_(season_8)"),
        
        //  Attribution: https://medium.com/@audrey96928626/the-top-20-biggest-man-made-disasters-37f7f2a1ed2
        Event(title: "Hindenburg Airship", year: 1937, url: "https://en.wikipedia.org/wiki/Hindenburg_disaster"),
        Event(title: "Jilin Chemical Explosion", year: 2005, url: "https://en.wikipedia.org/wiki/2005_Jilin_chemical_plant_explosions"),
        Event(title: "Tennesse Coal Ash Spill", year: 2008, url: "https://en.wikipedia.org/wiki/Kingston_Fossil_Plant_coal_fly_ash_slurry_spill"),
        Event(title: "Kuwaiti oil fires", year: 1991, url: "https://en.wikipedia.org/wiki/Kuwaiti_oil_fires"),
        Event(title: "Exxon Valdez Oil Spill", year: 1989, url: "https://en.wikipedia.org/wiki/Exxon_Valdez_oil_spill"),
        
        //  Attribution: https://list25.com/25-biggest-man-made-environmental-disasters-in-history/3/
        Event(title: "Baia Mare Water Cyanide Contamination", year: 2000, url: "https://en.wikipedia.org/wiki/2000_Baia_Mare_cyanide_spill"),
        Event(title: "Castle Bravo Nuclear Tests", year: 1954, url: "https://en.wikipedia.org/wiki/Castle_Bravo"),
        Event(title: "Minamata Poisonings", year: 1956, url: "https://en.wikipedia.org/wiki/Minamata_disease"),
        Event(title: "Three Mile Island Nuclear Explosion", year: 1979, url: "https://en.wikipedia.org/wiki/Three_Mile_Island_accident"),
        Event(title: "Darvaza gas crater (Door to Hell)", year: 1971, url: "https://en.wikipedia.org/wiki/Darvaza_gas_crater"),
        Event(title: "Amoco Cadiz Oil Tanker spill", year: 1978, url: "https://en.wikipedia.org/wiki/Amoco_Cadiz"),
        
        //  Attribution: https://www.infoplease.com/world/disasters/man-made
        Event(title: "Dhaka garment factory collapse", year: 2013, url: "https://en.wikipedia.org/wiki/2013_Dhaka_garment_factory_collapse"),
        Event(title: "Boston Marathon Bombing", year: 2013, url: "https://en.wikipedia.org/wiki/Boston_Marathon_bombing"),
        Event(title: "World Trade Center truck bomb", year: 1993, url: "https://en.wikipedia.org/wiki/1993_World_Trade_Center_bombing"),
        Event(title: "ARA San Juan submarine disappearance", year: 2017, url: "https://en.wikipedia.org/wiki/ARA_San_Juan_(S-42)"),
    ]
}
