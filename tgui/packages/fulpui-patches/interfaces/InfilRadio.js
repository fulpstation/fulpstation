import { useBackend } from '../../tgui/backend';
import { Box, Button, Section } from '../../tgui/components';
import { Window } from '../../tgui/layouts';

export const InfilRadio = (props, context) => {
  const { act, data } = useBackend(context);
  const { check, completed, dagd } = data;
  return (
    <Window width={360} height={130} theme="hackerman">
      <Window.Content>
        <Section>
          {(completed && !dagd && (
            <Box>
              You have proven yourself worthy of our final mission. The stereo
              system in our shuttle was stolen, we need you to grand theft auto
              their emergency escape shuttle for spares.
            </Box>
          )) ||
            (completed && dagd && (
              <Box>
                Frankly, we have no more uses for you and we would prefer if you
                removed all potential evidence of your existence. May you have
                an everlasting glorious death.
              </Box>
            )) ||
            (data.check
              ? 'Your work has satisfied our investors.'
              : 'Prove your worth by completing an objective.')}
        </Section>
        {!completed && (
          <Section>
            <Button
              content={check ? 'Claim Reward' : 'Reward Unavailable'}
              onClick={() => act('claim_reward')}
            />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
