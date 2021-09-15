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
    "The face of conspiracy theory was changed forever the day mankind met the lizards.",
    "Hailing from the arid world of Tizira, lizards were travelling the stars back when mankind was first discovering how neat trains could be. However, much like the space-fable of the space-tortoise and space-hare, lizards have rejected their kin's motto of \"slow and steady\" in favor of resting on their laurels and getting completely surpassed by 'bald apes', due in no small part to their lack of access to plasma.",
    "The history between lizards and humans has resulted in many conflicts that lizards ended on the losing side of, with the finale being an explosive remodeling of their moon. Today's lizard-human relations are seeing the continuance of a record period of peace.",
    "Lizard culture is inherently militaristic, though the influence the military has on lizard culture begins to lessen the further colonies lie from their homeworld - with some distanced colonies finding themselves subsumed by the cultural practices of other species nearby.",
    "On their homeworld, lizards celebrate their 16th birthday by enrolling in a mandatory 5 year military tour of duty. Roles range from combat to civil service and everything in between. As the old slogan goes: \"Your place will be found!\"",
  ],
};

export default Beefman;
