import { Antagonist, Category } from '../base';
import { multiline } from 'common/string';

const GhostInfiltrator: Antagonist = {
  key: 'infiltrator',
  name: 'Infiltrator',
  description: [
    multiline`
      Specialized stealth agents trained in espionage and in impeding
      Nanotrasen progress.
    `,

    multiline`
      Sneak your way onto the Space Station 13. Further the syndicate's
      interests right under Nanotrasen's nose! You have been equipped
      with sufficient gear to help you commit severe sabotage covertly.
    `,
  ],
  category: Category.Midround,
};

export default GhostInfiltrator;
