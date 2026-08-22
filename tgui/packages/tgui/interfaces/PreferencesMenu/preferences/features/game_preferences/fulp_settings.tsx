import { CheckboxInput, type FeatureToggle } from '../base';

export const antag_tips: FeatureToggle = {
  name: 'Antagonist tips',
  category: 'GAMEPLAY',
  description:
    'Gives a basic explanation on how to play an antagonist upon obtaining one.',
  component: CheckboxInput,
};

import { Box, TextArea } from 'tgui-core/components';
import type { Feature, FeatureValueProps } from '../base';

type FeatureShortTextData = {
  maximum_length: number;
};

export type FeatureMultiline = Feature<string, string, FeatureShortTextData>;

export function MultilineText(
  props: FeatureValueProps<string, string, FeatureShortTextData>,
) {
  const { serverData, value, handleSetValue } = props;
  if (!serverData) {
    return <Box>Loading...</Box>;
  }
  return (
    <TextArea
      width="100%"
      height={'52px'}
      value={value}
      maxLength={serverData.maximum_length || 1024}
      onBlur={handleSetValue}
    />
  );
}

export const flavor_text: FeatureMultiline = {
  name: 'Flavor - Flavor Text',
  description:
    'A small snippet of text shown when others examine you, \
    describing what you may look like.',
  component: MultilineText,
};
