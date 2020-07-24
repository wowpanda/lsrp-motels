Config = {}


Config.PriceRental            = 50      -- How much rental of a Motel Room apartment is - 0 = Free.
Config.Locale                 = 'en'    -- Only defaultly supports English, feel free to add addtional language support.
Config.SwitchCharacterSup     = false    -- Optional Please ensure you have added xXFriendlysXx Switch Character fix aswell.

Config.RoomMarker = {
    Owned = {r = 255, g = 0, b = 0},     -- Owned Motel Color
	x = 0.5, y = 0.5, z = 0.7  -- Standard Size Circle
}

Config.Zones = {

    PinkCage = {
        Name = "Pink Cage Motel",
        Pos = {x = 324.55, y = -212.44, z = 54.15, color = 23, sprite = 475, size = 1.0},
        roomExit = {x = 151.25, y = -1007.74, z = -99.00}, -- The Exit marker of the room, usually the only door hehe
        roomLoc = {x = 151.25, y = -1007.74, z = -99.00}, -- Where you will spawn IN the motel room
        BedStash = {x = 154.47, y = -1005.92, z = -99.0},  -- The Secret Stash Location of the Bed
        Inventory = {x = 151.83, y = -1001.32, z = -99.00},  -- The Inventory of the Room Main Storage
        Menu = {x = 151.32, y = -1003.05, z = -99.0}, -- Room Options Menu
        Boundries = 26.0, -- The Boundry Radius of the Motel (Will check ownerships etc.. if player is within this radius)
        Rooms = {
            Room1 = {
                number = 1,
                instancename = "pcm1",
                entry = {x = 312.83, y = -218.79, z = 54.22},
                    },

            Room2 = {
                number = 2,
                instancename = "pcm2",
                entry = {x = 310.9, y = -217.97, z = 54.22},
                    },

             Room3 = {
                number = 3,
                instancename = "pcm3",
                entry = {x = 307.24, y = -216.69, z = 54.22},
                    },

             Room4 = {
                number = 4,
                instancename = "pcm4",
                entry = {x = 307.58, y = -213.3, z = 54.22},
                     },

             Room5 = {
                number = 5,
                instancename = "pcm5",
                entry = {x = 309.51, y = -207.92, z = 54.22},
                    },

             Room5a = {
                number = "5a",
                instancename = "pcm5a",
                entry = {x = 311.27, y = -203.33, z = 54.22},
                    },

             Room6 = {
                number = 6,
                instancename = "pcm6",
                entry = {x = 313.36, y = -198.07, z = 54.22},
                    },

             Room7 = {
                number = 7,
                instancename = "pcm7",
                entry = {x = 315.77, y = -194.82, z = 54.22},
                    },

             Room8 = {
                number = 8,
                instancename = "pcm8",
                entry = {x = 319.4, y = -196.21, z = 54.22},
                    },

             Room9 = {
                number = 9,
                instancename = "pcm9",
                entry = {x = 321.44, y = -196.99, z = 54.22},
                    },

             Room11 = {
                number = 11,
                instancename = "pcm11",
                entry = {x = 312.83, y = -218.79, z = 58.02},
                    },

            Room12 = {
                number = 12,
                instancename = "pcm12",
                entry = {x = 310.9, y = -217.97, z = 58.02},
                    },

             Room13 = {
                number = 13,
                instancename = "pcm13",
                entry = {x = 307.24, y = -216.69, z = 58.02},
                    },

             Room14 = {
                number = 14,
                instancename = "pcm14",
                entry = {x = 307.58, y = -213.3, z = 58.02},
                    },

             Room15 = {
                number = 15,
                instancename = "pcm15",
                entry = {x = 309.51, y = -207.92, z = 58.02},
                    },

             Room16 = {
                number = 16,
                instancename = "pcm16",
                entry = {x = 311.27, y = -203.33, z = 58.02},
                    },

             Room17 = {
                number = 17,
                instancename = "pcm17",
                entry = {x = 313.36, y = -198.07, z = 58.02},
                    },

             Room18 = {
                number = 18,
                instancename = "pcm18",
                entry = {x = 315.77, y = -194.82, z = 58.02},
                    },

             Room19 = {
                number = 19,
                instancename = "pcm19",
                entry = {x = 319.4, y = -196.21, z = 58.02},
                    },

             Room20 = {
                number = 20,
                instancename = "pcm20",
                entry = {x = 321.44, y = -196.99, z = 58.02},
             },

             -- Left Side

             Room21 = {
                number = 21,
                instancename = "pcm21",
                entry = {x = 329.43, y = -225.02, z = 54.22},
             },
             Room22 = {
                number = 22,
                instancename = "pcm22",
                entry = {x = 331.44, y = -225.97, z = 54.22},
             },
             Room23 = {
                number = 23,
                instancename = "pcm23",
                entry = {x = 334.97, y = -227.36, z = 54.22},
             },
             Room24 = {
                number = 24,
                instancename = "pcm24",
                entry = {x = 337.09, y = -224.81, z = 54.22},
             },
             Room25 = {
                number = 25,
                instancename = "pcm25",
                entry = {x = 339.21, y = -219.45, z = 54.22},
             },
             Room26 = {
                number = 26,
                instancename = "pcm26",
                entry = {x = 340.8, y = -214.89, z = 54.22},
             },
             Room27 = {
                number = 27,
                instancename = "pcm27",
                entry = {x = 342.88, y = -209.6, z = 54.22},
             },
             Room28 = {
                number = 28,
                instancename = "pcm28",
                entry = {x = 344.59, y = -205.01, z = 54.22},
             },
             Room29 = {
                number = 29,
                instancename = "pcm29",
                entry = {x = 346.81, y = -199.73, z = 54.22},
             },

             --

             Room30 = {
                number = 30,
                instancename = "pcm30",
                entry = {x = 329.43, y = -225.02, z = 58.02},
             },
             Room31 = {
                number = 31,
                instancename = "pcm31",
                entry = {x = 331.44, y = -225.97, z = 58.02},
             },
             Room32 = {
                number = 32,
                instancename = "pcm32",
                entry = {x = 334.97, y = -227.36, z = 58.02},
             },
             Room33 = {
                number = 33,
                instancename = "pcm33",
                entry = {x = 337.09, y = -224.81, z = 58.02},
             },
             Room34 = {
                number = 34,
                instancename = "pcm34",
                entry = {x = 339.21, y = -219.45, z = 58.02},
             },
             Room35 = {
                number = 35,
                instancename = "pcm35",
                entry = {x = 340.8, y = -214.89, z = 58.02},
             },
             Room36 = {
                number = 36,
                instancename = "pcm36",
                entry = {x = 342.88, y = -209.6, z = 58.02},
             },
             Room37 = {
                number = 37,
                instancename = "pcm37",
                entry = {x = 344.59, y = -205.01, z = 58.02},
             },
             Room38 = {
                number = 38,
                instancename = "pcm38",
                entry = {x = 346.81, y = -199.73, z = 58.02},
             },

    }
}



}