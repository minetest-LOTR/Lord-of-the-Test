# DarkAge Mod for Minetest
Original mod by Master Gollum 
Modified by addi. 

Contains code from CragiDavi and HybridDog

## Introduction:
  This mod adds a few new blocks that allows to create new buildings in a
  pre industrial landscape. Of course, feel free to use them in any other 
  construction :P

  It also provides more layers of stones. I tried not to turn mining in
  a rainbow, so don't expect to find them easily. There are two kinds of
  materials, stones, that spawns in layers at different deep and clay
  like materials (silt and mud) that you will find in water places.
  Silt and Mud are more easy to find than stone layers, but if you find
  one it will be a real mine, with all probability with hundreds of blocks.

  I used mainly 4 square recipes to avoid collisions with other MODs, 
  anyway I have not checked all them, so it is possible that another 
  person is already using one or more of this combinations.

  I also used Desert Sand and Desert Stone, because they almost are not
  used in the default version. Probably I will change this recipes in 
  next releases.

  

## Release Notes
Version 1.2

* corrected Sounds of Stairs
* updated to new Moreblocks api
* added Serpentine Stairs

Version 1.1

* Fix spelling mistakes in README file
* Bug fix
* Rename slate_tale to slate_tile
* Remove unneeded code
* Add marble tile
* Remove unneeded code
* Capitalise a couple of descriptions
* Add marble tile texture
* Rename alias.lua to aliases.lua

Version 1.0.1 

 * fixed init.lua which get broken by upload on github


Version 1.0 

* compatibility with stairsplus added
* added new item iron_stick
* added craft reziep for iron stick
* changed reziep of iron_bars to avoid conflicts with iron bars mod
* changed reziep of chain to avoid conflicts with 3d furniture mod
* changed reziep of darkage:stonebrick to avoid conflicts with moreblocks
* disabled marble_tile to avoid the message "texture not found"
* added compatibility with stairsplus (now its moreblocks)
* added darkage:glass a nice looking glass that must be in this mod 
* changed the sound_node_leaves_default to wood_default from  box and wooden shelves
* added craft reziep for darkage:chalk
* improved the textures of reinforced wood and chalk to save a bit more loadtime on servers
* added another reziep for darkage straw (this can be crafted now, if farming is installed, with farming:harvested_weed

Version 0.3

* 29 Nodes + 3 Craft Items
* Furniture and building decoration
* Stone layers



Version 0.2

* 13 Nodes
* Sedimentary stones


Version 0.1

* 6 Nodes

PS: This document has been structured as the README.txt of PilzAdam in 
    his Bed MOD.

### How to install:
  Unzip the archive an place it in minetest-base-directory/mods/
  if you have a windows client or a linux run-in-place client. If you 
  have a linux system-wide installation place it in 
  ~/.minetest/mods/.
  If you want to install this mod only in one world create the folder
  worldmods/ in your worlddirectory. Remember to activate it for your world by pressing the 'configure' button and doubleclick darkage in the right list.
  For further information or help see:
   http://wiki.minetest.net/Installing_Mods

## BUILDING NODES

### Adobe: 
Sand and Clay mixture with Straw to build houses or walls.
Used from historical times, one of the first bricks 
invented. I have to improve this texture, it is ugly :P

     CRAFT -> 4
     [Sand] [Sand]
     [Clay Lump] [Straw]


### Basalt:
A darken version of the default Stone
  
     COOKING
     [Basalt Cobble]


### Basalt Cobble:
A darken version of the default Cobble.
  
     CRAFT -> 4
     [Cobble] [Cobble]
     [Coal Lump] [Coal Lump]


### Chalk:
A soft, white and porous sedimentary rock. It becomes
Chalk Powder when dug. Can't be craft, only found as stratum.


### Chalk Powder:
Pile of chalk from digging Chalk stones. Can
be used to prepare plaster. See Cobblestone with Plaster.


### Cobblestone with Plaster:
Cobbles where has been applied a
layer of white plaster.
When dug it lost the plaster layer!

     CRAFT -> 2
     [Cobblestone] [Chalk Powder]
     [Cobblestone] [Chalk Powder]


### Dark Dirt: 
A darken version of the Dirt where the grass doesn't
grown, perfect for create a path in a forest. I was using
Gravel, but the noise walking was annoying to me (like
walking over iron coal with the nude feet :P), for this I
created this node.

     CRAFT -> 4
     [Dirt] [Dirt]
     [Gravel] [Gravel]


### Desert Iron Ore:
I know that others MODs add ores to the 
Desert Stones, mine also does it, but just Iron, I supposed
the red color is because of the iron, so it goes with more
high probability than regular Stones and it doesn't add
Coal to them. It will not be a lot so you can keep it with
another MOD that does the same or just comment the lines that
does it.


### Dry Leaves:
Just a cube of Leaves toasted :P Well I found the
Leaves are not useful so I thought to turn them into Straw, ok
it is not the same, but well, why not? Just dry them in a
Furnace and then put together to create the Straw

     COOKING
     [Leaves]


### Gneiss:
High grade metamorphic rock formed from Schist, very
common, and used in construction. It sometimes brakes in
Gneiss Cobble when being dug.

     COOKING
     [Schist]


### Gneiss Cobble:
Brick version of the gneiss.
  
     From dig gneiss


### Mud:
Mixture of water and some combination of soil, silt, and
clay. Used for build houses, specially in desert regions.
It brakes in 4 Mud Lumps when dug.

     CRAFT -> 3
     [Dirt] [Dirt]
     [Clay Lump] [Silt Lump]

     CRAFT -> 1
     [Mud Lump] [Mud Lump]
     [Mud Lump] [Mud Lump]


### Old Red Sandstone:
A light red sandstone, in fact it's
sandstone with iron that gives it this color.

     CRAFT -> 4
     [Sandstone] [Sandstone]
     [Iron Lump] [Sandstone]

     COOKING
     [Old Red Sandstone Cobble]


### Old Red Sandstone Cobble:
Cobbles of Old Red Sandstone.
  
     CRAFT -> 4
     [Sandstone Cobble] [Sandstone Cobble]
     [Iron Lump] [Sandstone Cobble]


### Reinforced Cobble:
Brick with crossed wooden.
  
     CRAFT -> 1
     [Stick] [] [Stick]
     [] [Cobble] []
     [Stick] [] [Stick]


### Sandstone Cobble:
Brick version of the Sandstone, good for
buildings with a pale color.
	 
     COOKING
     [Sandstone]


### Schist:
Medium grade metamorphic rock from Slate.
  
     COOKING
     [Slate]


### Silt:
Granular material of a size somewhere between sand and clay.
It brakes in 4 Silt Lumps.
	 
     CRAFT -> 1
     [Silt Lump] [Silt Lump]
     [Silt Lump] [Silt Lump]


### Slate:
Fine-grained, foliated, homogeneous metamorphic rock
derived from an original shale-type sedimentary rock through
low-grade regional metamorphism. It is used to build roof.
	 
     COOKING
     [Shale]

     COOKING
     [Slate Cobble]

 
### Slate Cobble:
Cobble obtained from Slate

     From dig Slate


### Slate Tile:
Nice blue slate tiles for roofs. They has been used
as building traditional building material in zones where
slate is easy to find.
Note: It has stairs and slabs.
	 
     CRAFT -> 2
     [Slate Cobble] [Slate Cobble]
     [Slate Cobble] [Slate Cobble]


### Straw Bale:
 A decoration item, looks great for a farm or a 
 country side house.
	 
     CRAFT -> 1
     [Straw] [Straw]
     [Straw] [Straw]
 

### Desert Stone:
 Just the default block, it can be obtained now
 from Desert Sand. The idea is that Desert Sand is stonier
 than regular Sand, so it takes less to create a Desert
 Stone than a Sandstone.
	 
     CRAFT -> 2
     [Sandstone] [Sandstone]
     [Sandstone] [Sandstone]


##FURNITURE NODES
Just started so they are few ones

### Box:
A more smaller container than the Chest, but it requires
less wood. As cheep as 4 woods and have 16 slots. The craft
is a little weird but I think it makes sense and avoids
collision with the recipe of Hardwood of the MOD 
building_blocks.
     
     CRAFT -> 2
     [Wood] [] [Wood]
     [] [] []
     [Wood] [] [Wood]

### Chain:
Climbable chain.
  
     CRAFT -> 2
     [Steel Ingot]
     [Steel Ingot]
     [Steel Ingot]


### Iron Bars:
 Alternative window for the Glass.
  
     CRAFT -> 3
     [Iron Stick] [] [Iron Stick]
     [Iron Stick] [] [Iron Stick]
     [Iron Stick] [] [Iron Stick]


###Iron Grille:
 Alternative window for the Glass.
  
     CRAFT -> 3
     []          [Iron Bars]      []
     [Iron Bars]     []       [Iron Bars]
     []          [Iron Bars]      []


###Wood Bars:
Alternative window for the Glass.
  
     CRAFT -> 3
     [Stick] [] [Stick]
     [Stick] [] [Stick]
     [Stick] [] [Stick]


###Wood Frame:
Alternative window for the Glass.
  
     CRAFT -> 1
     [Stick] [Stick]  [Stick]
     [Stick] [Glass]  [Stick]
     [Stick] [Stick]  [Stick]


### Medieval Glass:
A good looking glass, with small tiles
  
     CRAFT -> 8
     [Glass]       [steel_ingot]       [Glass]
     [steel_ingot] [Glass]       [steel_ingot]
     [Glass]       [steel_ingot]       [Glass]

     or:
     CRAFT -> 1
     [Medieval Glow Glass]


### Medieval Glow Glass:
A good looking glass, with small tiles which are glowing by itself
  
     CRAFT -> 8
     [Medieval Glass]
     [torch] 
	 
	 
##License:
Sourcecode: WTFPL (see below)
Graphics: WTFPL (see below)

#See also:
http://minetest.net/

---


```
#!

         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```