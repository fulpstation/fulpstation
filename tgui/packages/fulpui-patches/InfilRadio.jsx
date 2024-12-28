import { useBackend } from '../tgui/backend';
import { Box, Button, Section } from '../tgui/components';
import { Window } from '../tgui/layouts';

export const InfilRadio = (props) => {
  const { act, data } = useBackend();
  const { check, completed, final } = data;
  return (
    <Window width={360} height={130} theme="hackerman">
      <Window.Content>
        <Section>
          {(completed && <Box> {final} </Box>) ||
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
