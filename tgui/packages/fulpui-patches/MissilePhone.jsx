import { useBackend } from '../tgui/backend';
import { Box, Button, Section } from '../tgui/components';
import { Window } from '../tgui/layouts';

export const MissilePhone = (props) => {
  const { act, data } = useBackend();
  const { used, disk_inserted, can_use } = data;
  return (
    <Window width={360} height={130} theme="hackerman">
      <Window.Content>
        <Section>
          {(used && (
            <Box>Missiles Successfully launched towards the station.</Box>
          )) ||
            (!disk_inserted && (
              <Box>
                Awaiting station coordinates. Please upload coordinates to
                machine via disk.
              </Box>
            )) ||
            (can_use && (
              <Box>
                Coordinates recieved. Barrage of missiles ready to be launched.
              </Box>
            ))}
        </Section>
        {!used && (
          <Section>
            <Button
              content={can_use ? 'Launch Missiles' : 'Missiles Unavailable'}
              onClick={() => act('launch_missiles')}
            />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
