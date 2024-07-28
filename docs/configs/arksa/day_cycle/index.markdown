---
title: Day and Night Cycle
parent: "Ark: Survival Ascended"
grand_parent: Config Editors
configkeys:
  - DayCycleSpeedScale
  - DayTimeSpeedScale
  - NightTimeSpeedScale
supportedgames:
  - "Ark: Survival Ascended"
---
{% include editortitle.markdown %}

Ark allows server admins to control the speed of the days and nights individually.

{% include image.html file="daycycle.png" file2x="daycycle@2x.png" caption="Beacon's Day and Night Cycle Editor." %}

Users may edit any of the fields. For example, increasing the **Night Time Multiplier**{:.ui-keyword} from 1 to 2 will update the **Night Time Result**{:.ui-keyword} from 18.62 to 9.31 minutes. Adjusting the **Night Time Result**{:.ui-keyword} back down to 16.62 will set the **Night Time Multiplier**{:.ui-keyword} to 1. Higher multiplier values will make time progress faster.

The **Full Cycle**{:.ui-keyword} value displays the total time it will take to complete one 24-hour cycle in the game.

Server admins interested in making their in-game days last one real time day might use 960 minutes for day and 480 minutes for night, equalling 1,440 total minutes.

### Aberration Seasons

Aberration day and night length are based on 10-day "seasons." Days ending in 0-3 are more balanced, while days ending in 4-6 have much longer days, and days ending in 7-9 have much longer nights. Like before, the lengths can be adjusted, but affect the global day and night multipliers. It is not possible to adjust season lengths individually.

{% include affectedkeys.html %}