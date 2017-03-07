//
//  RemoteConfigDefaults.swift
//  Green Thumb
//
//  Created by Jennifer Person on 2/13/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import Foundation
import UIKit

var plantsArray = [PlantObject(name: "Fennel",
                               details: "Life Cycle: Perennial \r\n Full Size: 1.5 m (5ft) by 1 m (3ft 3in) \r\n Hardiness: zone (UK) 5 \r\n Flowers: August to October \r\n Soil Type: light (sandy), medium (loamy), and heavy (clay). Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic (alkaline) soils \r\n Sunlight: Full sun \r\n Watering: Dry or moist soil. Tolerates drought",
                               price: 20),
                   PlantObject(name: "Asparagus",
                               details: "Life Cycle: Perennial \r\n Full Size: 1.5 m (5ft) \r\n Hardiness: zone (UK) 8, frost tender \r\n Flowers: Aug to September \r\n Soil Type: light (sandy) and medium (loamy) soils. Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic (alkaline) soils \r\n Sunlight: Full sun or semi-shade \r\n Watering: Dry or moist soil. Tolerates drought",
                               price: 35 ),
                   PlantObject(name: "Carrot",
                               details: "Life Cycle: Biennial \r\n Full Size: 1.2 m (4ft) by 0.3 m (1ft in) \r\n Hardiness: zone (UK) 5. Not frost tender \r\n Flowers: Jun to August \r\n Soil Type: light (sandy), medium (loamy), and heavy (clay). Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic (alkaline) soils \r\n Sunlight: Full sun \r\n Watering: Moist soil.",
                               price: 20),
                   PlantObject(name: "Cucumber",
                               details: "Life Cycle: Annual \r\n Full Size: 2 m (6ft 7in) \r\n Hardiness: zone (UK) 10. Frost tender \r\n Flowers: Jul to September \r\n Soil Type: light (sandy), medium (loamy), and heavy (clay). Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic (alkaline) soils \r\n Sunlight: Full sun \r\n Watering: moist soil",
                               price: 40),
                   PlantObject(name: "Potato",
                               details: "Life Cycle: Perennial \r\n Full Size: 3 m (9ft 10in) at a fast rate \r\n Hardiness: zone (UK) 9. Is frost tender \r\n Soil Type: light (sandy) and medium (loamy). Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic (alkaline) soils \r\n Sunlight: Full sun \r\n Watering: moist soil",
                               price: 30),
                   PlantObject(name: "Mint",
                               details: "Life Cycle: Perennial \r\n Hardiness: zone (UK) 6. Not frost tender \r\n Flowers: August to October \r\n Soil Type: light (sandy), medium (loamy), and heavy (clay). \r\n Suitable pH: acid, neutral and basic (alkaline) soils \r\n Sunlight: Full sun or semi-shade \r\n Watering: moist soil",
                               price: 65),
                   PlantObject(name: "Beet",
                               details: "Life Cycle: Biennial \r\n Full Size: 0.9 m (3ft) \r\n Hardiness: zone (UK) 5. Not frost tender \r\n Soil Type: light (sandy), medium (loamy), and heavy (clay). Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic (alkaline) soils. can grow in very alkaline and saline soils. \r\n Sunlight: Full sun \r\n Watering: moist soil", price: 40),
                   PlantObject(name: "Bok choy",
                               details: "Life Cycle: Biennial \r\n Full Size: 0.9 m (3ft) \r\n Hardiness: zone (UK) 7. Not frost tender. \r\n Flowers: May to August \r\n Soil Type: light (sandy), medium (loamy), and heavy (clay). Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic",
                               price: 25),
                   PlantObject(name: "Snap peas", details: "Life Cycle: Annual \r\n Full Size: 2 m (6ft 7in) \r\n Hardiness: Not frost tender. \r\n Flowers: May to September \r\n Soil Type: light (sandy) and medium (loamy). Prefers well-drained soil. \r\n Suitable pH: acid, neutral and basic (alkaline) soils \r\n Sunlight: Full sun \r\n Watering: moist soil",
                               price: 50)]
let advancedArray = [PlantObject(name: "Fennel",
                                 details: "Foeniculum vulgare is an evergreen perennial growing to 1.5 m (5ft) by 1 m (3ft 3in). \r\n It is hardy to zone (UK) 5 and is not frost tender. It is in leaf 12-Jan It is in flower from Aug to October, and the seeds ripen from Sep to October. The flowers are hermaphrodite (have both male and female organs) and are pollinated by Insects.The plant is self-fertile. \r\n It is noted for attracting wildlife. \r\n Suitable for: light (sandy), medium (loamy) and heavy (clay) soils and prefers well-drained soil. Suitable pH: acid, neutral and basic (alkaline) soils. It cannot grow in the shade. It prefers dry or moist soil and can tolerate drought. The plant can tolerates strong winds but not maritime exposure.",
                                 price: 20),
                     PlantObject(name: "Asparagus",
                                 details: "Asparagus officinalis is a perennial growing to 1.5 m (5ft) by 0.8 m (2ft 7in). \r\n It is hardy to zone (UK) 4 and is not frost tender. It is in flower in August, and the seeds ripen from Sep to October. The flowers are dioecious (individual flowers are either male or female, but only one sex is to be found on any one plant so both male and female plants must be grown if seed is required) and are pollinated by Bees.The plant is not self-fertile. \r\n It is noted for attracting wildlife. \r\n Suitable for: light (sandy), medium (loamy) and heavy (clay) soils and prefers well-drained soil. Suitable pH: acid, neutral and basic (alkaline) soils and can grow in very acid, very alkaline and saline soils. \r\n It can grow in semi-shade (light woodland) or no shade. It prefers moist soil. The plant can tolerate maritime exposure.",
                                 price: 35),
                     PlantObject(name: "Carrot",
                                 details: "Daucus carota sativus is a biennial growing to 1.2 m (4ft) by 0.3 m (1ft in). \r\n It is hardy to zone (UK) 5 and is not frost tender. It is in flower from Jun to August, and the seeds ripen from Aug to September. The flowers are hermaphrodite (have both male and female organs) and are pollinated by Flies, beetles.The plant is self-fertile. \r\n Suitable for: light (sandy), medium (loamy) and heavy (clay) soils and prefers well-drained soil. Suitable pH: acid, neutral and basic (alkaline) soils. It cannot grow in the shade. It prefers moist soil. The plant can tolerates strong winds but not maritime exposure.",
                                 price: 20),
                     PlantObject(name: "Cucumber",
                                 details: "Cucumis sativus is an annual climber growing to 2 m (6ft 7in). \r\n It is hardy to zone (UK) 10 and is frost tender. It is in flower from Jul to September, and the seeds ripen from Aug to October. The flowers are monoecious (individual flowers are either male or female, but both sexes can be found on the same plant) and are pollinated by Insects.The plant is self-fertile. \r\n Suitable for: light (sandy), medium (loamy) and heavy (clay) soils and prefers well-drained soil. Suitable pH: acid, neutral and basic (alkaline) soils. It cannot grow in the shade. It prefers moist soil.", price: 40),
                     PlantObject(name: "Potato",
                                 details: "Ipomoea batatas is a perennial climber growing to 3 m (9ft 10in) at a fast rate. \r\n It is hardy to zone (UK) 9 and is frost tender. The flowers are hermaphrodite (have both male and female organs)Suitable for: light (sandy) and medium (loamy) soils and prefers well-drained soil. Suitable pH: acid and neutral soils. It cannot grow in the shade. It prefers moist soil.",
                                 price: 30),
                     PlantObject(name: "Mint",
                                 details: "Mentha requienii is a perennial. \r\n It is hardy to zone (UK) 6 and is not frost tender. It is in flower from Jul to August. The flowers are hermaphrodite (have both male and female organs) and are pollinated by Insects. It is noted for attracting wildlife. \r\n Suitable for: light (sandy), medium (loamy) and heavy (clay) soils and can grow in heavy clay soil. Suitable pH: acid, neutral and basic (alkaline) soils. It can grow in semi-shade (light woodland) or no shade. It prefers moist soil.",
                                 price: 65),
                     PlantObject(name: "Beet",
                                 details: "Beta vulgaris cicla is a biennial growing to 0.9 m (3ft). \r\n It is hardy to zone (UK) 5 and is not frost tender. The flowers are hermaphrodite (have both male and female organs) and are pollinated by Wind.Suitable for: light (sandy), medium (loamy) and heavy (clay) soils and prefers well-drained soil. Suitable pH: acid, neutral and basic (alkaline) soils and can grow in very alkaline and saline soils. \r\n It cannot grow in the shade. It prefers moist soil.",
                                 price: 40),
                     PlantObject(name: "Bok choy",
                                 details: "Brassica rapa chinensis is a biennial growing to 0.9 m (3ft). \r\n It is hardy to zone (UK) 7 and is not frost tender. It is in flower from May to August. \r\n The flowers are hermaphrodite (have both male and female organs) and are pollinated by Bees, self. \r\n The plant is self-fertile.Suitable for: light (sandy), medium (loamy) and heavy (clay) soils and prefers well-drained soil. Suitable pH: acid, neutral and basic (alkaline) soils. \r\n It can grow in semi-shade (light woodland) or no shade. It prefers moist soil.",
                                 price: 25),
                     PlantObject(name: "Snap peas",
                                 details: "Pisum sativum is an annual growing to 2 m (6ft 7in). \r\n It is not frost tender. It is in flower from May to September, and the seeds ripen from Jul to October. The flowers are hermaphrodite (have both male and female organs) and are pollinated by Self. Occasionally bees.The plant is self-fertile. \r\n It can fix Nitrogen. \r\n Suitable for: light (sandy) and medium (loamy) soils and prefers well-drained soil. Suitable pH: neutral and basic (alkaline) soils. It cannot grow in the shade. It prefers moist soil.",
                                 price: 50)
]
