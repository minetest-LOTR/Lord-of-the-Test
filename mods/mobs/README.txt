-= MOBS-MOD for MINETEST =-
by PilzAdam, KrupnovPavel, Zeg9 and TenPlus1


https://forum.minetest.net/viewtopic.php?f=9&t=9917

This mod contains the following additions:

- Giant Spiders (found in desert caves, drop string when killed)
- Bee's (found around flowers, drop honey when killed, right-click to pick up, also Beehives)
- Chicken (lays eggs, added fried egg, raw & cooked chicken, right-click to pick up)
- Cow (right-click with empty bucket to get bucket of milk, feed 8 wheat to replenish milk)
- Sheep (right-click for wool, feed 8 wheat to replenish wool)
- Warthog (the local pig that gives raw and cooked port)
- Rats (right-click to pick up and place, cook for a tasty treat)
- Sand, Dirt, Stone, Tree Monsters, Oerkki and Dungeon Masters as standard
- Lava Flan, Mese Monsters added to spice things up a bit
- Cook milk in furnace to get cheese wedge, 9 wedges make 1 cheese block

..with the following new features:

- Hitting a mob has knock-back effect like in minecraft, and with blood effect
- Mobs float in water, so monsters can still chase you
- Mobs can die from falling from a height
- Mobs have better health and drops
- Hitting a mob also puts them into fight mode (apart from animals)
- Compatible with Ethereal mod, mobs now spawn on ethereal worlds

Changelog:

1.12- Added animal ownership so that players cannot steal your tamed animals
1.11- Added flying mobs (and swimming), fly=true and fly_in="air" or "deafult:water_source" for fishy
1,10- Footstep removed (use replace), explosion routine added for exploding mobs. 
1.09- reworked breeding routine, added mob rotation value, added footstep feature, added jumping mobs with sounds feature, added magic lasso for picking up animals
1.08- Mob throwing attack has been rehauled so that they can damage one another, also drops and on_die function added
1.07- Npc's can now be set to follow player or stand by using self.order and self.owner variables
beta- Npc mob added, kills monsters, attacks player when punched, right click with food to heal or gold lump for drop
1.06- Changed recovery times after breeding, and time taken to grow up (can be sped up by feeding baby animal)
1.05- Added ExeterDad's bunny's which can be picked up and tamed with 4 carrots from farming redo or farming_plus, also shears added to get wool from sheep and lastly Jordach/BSD's kitten
1.04- Added mating for sheep, cows and hogs...  feed animals to make horny and hope for a baby which is half size, will grow up quick though :)
1.03- Added mob drop/replace feature so that chickens can drop eggs, cow/sheep can eat grass/wheat etc.
1.02- Sheared sheep are remembered and spawn shaven, Warthogs will attack when threatened, Api additions
1.01- Mobs that suffer fall damage or die in water/lava/sunlight will now drop items
1.0 - more work on Api so that certain mobs can float in water while some sink like a brick :)
0.9 - Spawn eggs added for all mobs (admin only, cannot be placed in protected areas)...  Api tweaked
0.8 - Added sounds to monster mobs (thanks Cyberpangolin for the sfx) and also chicken sound
0.7 - mobs.protected switch added to api.lua, when set to 1 mobs no longer spawn in protected areas, also bug fixes
0.6 - Api now supports multi-textured mobs, e.g oerkki, dungeon master, rats and chickens have random skins when spawning (sheep fix TODO), also new Honey block
0.5 - Mobs now float in water, die from falling, and some code improvements
0.4 - Dungeon Masters and Mese Monsters have much better aim due to shoot_offset, also they can both shoot through nodes that aren't walkable (flowers, grass etc) plus new sheep sound :)
0.3 - Added LOTT's Spider mob, made Cobwebs, added KPavel's Bee with Honey and Beehives (made texture), Warthogs now have sound and can be tamed, taming of shaved sheep or milked cow with 8 wheat so it will not despawn, many bug fixes :)
0.2 - Cooking bucket of milk into cheese now returns empty bucket
0.1 - Initial Release