![header](https://raw.githubusercontent.com/minetest-LOTT/Lord-of-the-Test/master/menu/header.png)
## Lord of the Test: A Minetest Game.
This is a game for Minetest that adds [Lord of the Rings](https://en.wikipedia.org/wiki/The_Lord_of_the_Rings) elements into the game.

### Version: 1.2.0: The End of the Road ... for now

-----------------------------------------------------------------------------------------------

*The Road goes ever on and on*

*Out from the door where it began.*

*Now far ahead the Road has gone,*

*Let others follow it who can!*

*Let them a journey new begin,*

*But I at last with weary feet*

*Will turn towards the lighted inn,*

*My evening-rest and sleep to meet.*

-----------------------------------------------------------------------------------------------
### Message from the Developers - The road ahead
It's been almost 3 years since the last stable release, so here's a new one...

Now, over 6 years after the first days of Lord of the Test, and more than 5 years after it first appeared on github, work on this version has come to an end.

While it's not perfect, it has certainly come a long way since its first days, when it began life as a modpack, rather than a game. It originally used just the default mapgen, now it has it's own special one - albeit imperfect. There are a greater variety of mobs, more features, fewer bugs. The features of the Minetest engine have advanced incredibly. Both of us have learnt a lot in terms of coding, design, planning and building a game. We've had help with coding from people from all over the globe. We've had support from countless people, some who have been in Minetest since the very start of Lord of the Test, some who joined later and are still with us, and others who have left, for one reason or another. At one time, there was support for both Minetest and Freeminer! There have been various servers running Lord of the Test, some managed and developed by us, some independently.

There's still a lot of work which could be done on it, a lot of features that could be added, but the base which it is all built upon still has large parts of code from 2013, when neither of us had an idea of how to code, or of what direction we wanted the game to go in. So a lot of the code one finds in the game is messy, unreadable, a combination of mods forced to work together. The game is based on Minetest Game, but since the time we made that our base, it has only been synced a few times, the last many years ago, and now, there is a lot of content in it that we feel would be unsuited for Middle Earth. In addition, we have changed a lot of the mods from Minetest Game to a greater or lesser extent, making the task of updating them rather daunting. But, at the same time, this means that we lose out on many of the bugfixes/performance improvements/security fixes which have been added. In addition to all of this, since we have our base in Minetest Game, it looks as if mods supporting Minetest Game should be compatible with Lord of the Test, when in actual fact, they are often not, due to part of the game overriding them, or causing crashes when they use functions from Minetest Game which were only added later.

So, when we considered the way forward, we had two possibilities ahead of us. Either, we could have decided to go through all of the code, back-porting fixes, rewriting messy portions, redesigning what we didn't like, updating Minetest Game, or, we could rewrite the game from scratch. This decision wasn't easy to make, and it took a long time to reach, with many discussions (some rather heated!) along the way. But in the end, we both decided that the best course of action was to redo everything from scratch, coding our own systems as much as possible, and focusing on a coherent, unique design.

If you've been following the development of Lord of the Test rewrite on [Github](https://github.com/minetest-LOTR/Lord-of-the-Test/tree/v2-rewrite), you may have seen that work has been going into this for the past couple of years. There's not been an awful lot of progress, as both of us have been very busy, but work is slowly progressing forward. Below, you'll see a few of the things that we want to do with the rewrite.

 We will rename Lord of the Test to "Lord of the Test: Third Age (LTTA)". The main focus for LTTA is optimized code and polished features, and through that, the rewrite will feature a range of new efficient and polished features. Among some things to expect are;

 - A new mapgen, with lots of biomes, which is accurate to Middle-Earth geography rather than scattered randomly-placed biomes.
 - Massively reworked races/classes system, featuring great variety of races and subraces.
 - Various gameplay systems will be re-hauled to fit better within the context of LTTA, some examples are farming, weapons, crafting, armour, inventory, all providing new and different polished gameplay.
 - Work is being put into the various visuals too, with nice new textures, new mobs models and even a new, unique player model!

Simply put, expect LTTA to be vastly different from LOTT!

All of these things are just what we've got planned for the beginning, later on, there'll be an even greater variety of content, including a whole new quests system, a dialogue system, a complete array of mobs, and so much more!
But all of this will take time. We remain busy, and are likely to be so for the foreseeable future. So, if you want to help in shaping Middle Earth in Minetest, get in touch!

You can find us at IRC [#lordofthetest on libera](https://web.libera.chat/?channels=#lordofthetest) and at discord  [here](https://discord.gg/3qyymp2)

Thank you all for your support and help along the journey - we wouldn't have been able to this far without your help! While this part of the road is over, there is an even bigger one ahead of us!  The journey is exciting, and who knows where it will lead? Stay tuned for more information, and if you want, keep an eye out for a possible new development blog [here](https://minetest-lotr.github.io/)!

*- fishyWET (neinwhal) & Amaz*

-----------------------------------------------------------------------------------------------

### Maintenance and Future Contributions

Since the game has reached its end of development, no more new features should be added.

LOTT will now be strictly restricted to only bugfixes or minor improvements. Only bugfix releases will be released.

If you wish to contribute, please see [CONTRIBUTING.md](https://github.com/minetest-LOTR/Lord-of-the-Test/blob/master/CONTRIBUTING.md) for further information.

-----------------------------------------------------------------------------------------------

#### Installation:

To install this game [download it](https://github.com/minetest-LOTR/Lord-of-the-Test/releases/latest), and extract the zip to <your minetest folder>/games/Lord-of-the-Test.

On Linux, the folder which contains the games folder is .minetest in your home directory. (You may need to use ctrl+h to show hidden files.)

On Windows, the games folder will be located around the directory where minetest.exe is located, and can be accessed from the main directory where the minetest's data is located.

If you need more assistance with this, please refer to [these instructions](http://wiki.minetest.net/Subgame#Installing_subgames)


-----------------------------------------------------------------------------------------------

#### License:

Code: *LGPL v2.1*

Textures: *CC BY-SA 3.0*

See the license.txt of each mod for more information regarding authorship of each mod.

-----------------------------------------------------------------------------------------------

#### Contributors:

See [CONTRIBUTING.md](https://github.com/minetest-LOTR/Lord-of-the-Test/blob/master/CONTRIBUTING.md) if you want to contribute.

A full list of contributors can be found here:

[**List of Awesome Contributors**](https://github.com/minetest-LOTR/Lord-of-the-Test/graphs/contributors)

Additional contributors *(who are not listed above due to them not pushing their work directly to this repository)*:

- AspireMint
- Gabo (@GaboXandre)
- philipbenr (@philipbenr)
- STHGOM / sparky
- Thomas-S (@Thomas--S)

minetest-LOTR Members:
- fishyWET (@neinwhal)
- Amaz (@Amaz1)
- Lumidify Productions (@lumidify)

-----------------------------------------------------------------------------------------------
