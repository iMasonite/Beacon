---
title: Creature Adjustments
parent: "Ark: Survival Ascended"
grand_parent: Config Editors
configkeys:
  - DinoClassDamageMultipliers
  - DinoClassResistanceMultipliers
  - DinoClassSpeedMultipliers
  - NPCReplacements
  - PreventDinoTameClassNames
  - PreventTransferForClassNames
  - TamedDinoClassDamageMultipliers
  - TamedDinoClassResistanceMultipliers
  - TamedDinoClassSpeedMultipliers
  - TamedDinoClassStaminaMultipliers
supportedgames:
  - "Ark: Survival Ascended"
requiresomni: true
---
{% include editortitle.markdown %}

Ark server admins are able to fine-tune certain creature/dino stats, such as increasing resistant to damage or making them untameable. This guide will also cover removing certain creatures from the map, as well as a limited ability to replace one creature with another.

{% include image.html file="defaulteditor.png" file2x="defaulteditor@2x.png" caption="The default empty creature adjustments editor." %}

## Defining an Adjustment

Press the **New Adjustment**{:.ui-keyword} button in the upper left to begin defining a new creature adjustment. Your default editor will look like this:

{% include image.html file="nocreature.png" file2x="nocreature@2x.png" caption="The creature adjustment editor before selecting a creature." %}

First press the **Choose**{:.ui-keyword} button next to **Creature**{:.ui-keyword} to select the creature to change. Use the search field to quickly find the creature you're looking for. It may be necessary to adjust the tags using the tag picker above the list. {% include tags.markdown %}

{% include image.html file="pickcreature.png" file2x="pickcreature@2x.png" caption="Selecting a creature to adjust." %}

Once a creature has been selected, you must choose what to do with the creature.

### Change Multipliers

{% include image.html file="changemultipliers.png" file2x="changemultipliers@2x.png" caption="These options allow you to adjust the damage and resistance of the creature." %}

Four multipliers can be adjusted to tune the creature. Damage is the damage dealt by the creature, and Resistance is the damage blocked by the creature. Wild values do not affect tamed creatures, and tamed values do not affect wild creatures. This means a creature with 2.0 wild damage and 1.0 tamed damage will lose damage once tamed.

For those familiar with the `StructureResistanceMultiplier` setting, where < 1.0 means decreased damage, creature resistance works in the opposite direction. This value is the _divisor_ in the damage equation. So if a creature is about to be hurt by 100 damage, divide that 100 by the resistance multiplier to get the actual damage applied. For example, `100 / 2 = 50`, `100 / 0.5 = 200`, and `100 / 0 = NaN`. In that last case, Ark simply kills the creature when any damage at all.

To make the creature not able to be tamed, check the **Prevent Taming**{:.ui-keyword} checkbox. The **Prevent Transfer**{:.ui-keyword} checkbox means the creature cannot be downloaded from an Obelisk.

### Replace Creature

{% include image.html file="replacecreature.png" file2x="replacecreature@2x.png" caption="Beacon allows you to replace one creature with another." %}

With this option, you will be given a button to choose a replacement creature. **But this option will probably not do what you intend**.

While Ark allows replacing one creature with another, the replacement creature must already exist on the map. This is because the replacement option does **not** load the replacement creature into memory. This is an Ark behavior, not Beacon. Choosing a replacement creature that does not spawn on the map will effectively disable the replaced creature.

Beacon has a solution for this. Setup the replacement anyway, even though it won't work. Then use the **Tools**{:.ui-keyword} button in the Project Toolbar to choose **Convert Creature Replacements to Spawn Point Additions**{:.ui-keyword}. This will take any replacement lines found in the **Creature Adjustments**{:.ui-keyword} editor, change them to a disable line, and add overrides to the **Creature Spawns**{:.ui-keyword} editor to insert the replacement creature into every spawn point at the same rate as the original. It may be necessary to perform a wild dino wipe to clear already-spawned creatures off the map. This can be done with the cheat code `cheat destroywilddinos`.

To prevent players from bringing the replaced creature onto the map from other servers, you may want to also check the **Prevent Transfer**{:.ui-keyword} option.

### Disable Creature

{% include image.html file="disablecreature.png" file2x="disablecreature@2x.png" caption="Disabling a creature has no options." %}

The **Disable Creature**{:.ui-keyword} option will prevent the creature from spawning anywhere on the map. It may be necessary to perform a wild dino wipe to clear already-spawned creatures off the map. This can be done with the cheat code `cheat destroywilddinos`.

To prevent players from bringing the disabled creature onto the map from other servers, you may want to also check the **Prevent Transfer**{:.ui-keyword} option.

{% include affectedkeys.html %}