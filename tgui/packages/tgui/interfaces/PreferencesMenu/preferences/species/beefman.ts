import { createLanguagePerk, Species } from "./base";

const Beefman: Species = {
  description: "Made entirely out of beef, Beefmen are completely delusional \
    through and through, with constant hallucinations and 'tears in reality'.",
  features: {
    good: [{
      icon: "user",
      name: "Beefy Limbs",
      description: "Beefmen are able to tear off and put limbs back on at will \
        They do this by targetting their limb and right clicking.",
    }, {
      icon: "fist-raised",
      name: "Runners",
      description: "Beefmen are 20% faster than other species by default, \
        Allowing them to outrun things that normal crewmembers cannot.",
    }, {
      icon: "link",
      name: "Phobetor Tears",
      description: "Beefmen can see and use Phobetor tears, small tears in reality that, \
        When used, teleports you to the other end of the tear. This cannot if someone is near the start and end.",
    }, {
      icon: "temperature-low",
      name: "Cold Loving",
      description: "Beefmen are completely immune to the cold, even helping them prevent bleeding.",
    }, createLanguagePerk("Space Russian")],
    neutral: [],
    bad: [{
      icon: "shield-alt",
      name: "Boneless Meat",
      description: "Beefmen's meat is not well guarded, taking 20% more damage than normal crew.",
    }, {
      icon: "tint",
      name: "Juice Bleeding",
      description: "Beefmen will begin to bleed out when their temperature is above 24C, \
        Though scaling burn damage will prevent the bleeding.",
    }, {
      icon: "briefcase-medical",
      name: "Insanity",
      description: "Beefmen are completely insane, suffering from permanent hallucinations.",
    }],
  },
  lore: [
    "On a very quiet day, the Chef was cooking food for the crew, they realized they were out of meat. They decided that they would pay a visit to the Morgue, unaware of the consequences for their actions. It was going to be a one time thing anyways, who would mind a body or two missing? They thought, as they grabbed a body laying on a morgue tray.",
    "What the Chef hadn't noticed, the Morgue's soul alarm was off, the body was filled with a soul begging not to be gibbed.",
    "The chef one'd and two'd the body into the gibber and turned it on, the grinder struggling to keep up on its unupgraded parts. Once the whole body entered the machine, it suddenly stopped working, and instead started spitting the meat back out...",
    "But this wasn't regular meat. It had eyes, and a mouth too. Realizing what had happened, the scared Chef immediately called Security, who refused to arrest the new 'Beefman', who grew attached to the Chef.",
    "Years later, the Russian Sol Government offered to buy the Beefman off of them, to which the Chef gladly accepted. What the Russian Sol Government has done with them has never been released, but since then, there seems to have more of them than people remember, and these 'Beefmen' have never been able to sleep or think straight ever again.",
  ],
};

export default Beefman;
