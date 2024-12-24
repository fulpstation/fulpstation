import { useBackend } from '../tgui/backend';
import { Box, Button, Dropdown, Stack } from '../tgui/components';
import { Window } from '../tgui/layouts';

const HunterObjectives = (props) => {
  const { act, data } = useBackend();
  const { objectives = [], all_completed, rabbits_found, used_up } = data;
  return (
    <Stack vertical fill>
      <Stack.Item>
        <Dropdown
          over
          width="100%"
          options={objectives.map((objective) => objective.explanation)}
          displayText={'Incomplete Objectives'}
        />
      </Stack.Item>
      <Stack.Item>
        <Box>
          <Button
            fluid
            textAlign="center"
            align="center"
            content={'Commence Apocalypse'}
            fontSize="200%"
            disabled={!all_completed || !rabbits_found || used_up}
            onClick={() => act('claim_reward')}
            tooltip={
              'Only unlocked once all objectives are completed and rabbits are found, this will allow you to start your Final Reckoning.'
            }
          />
        </Box>
      </Stack.Item>
    </Stack>
  );
};

export const HunterContract = (props) => {
  const { act, data } = useBackend();
  const { items = [], bought } = data;
  return (
    <Window
      width={500}
      height={365}
      theme="spookyconsole"
      title="Hunter's Contract"
    >
      <Window.Content scrollable>
        {
          <Stack vertical fill>
            <Button
              icon="question"
              fontSize="20px"
              textAlign="center"
              tooltip={
                'Select one item to be your Hunting tool. You may only choose one, so pick wisely!'
              }
            >
              Uplink Items
            </Button>
            <Stack.Item>
              {items.map((item) => (
                <Box key={item.name} className="candystripe" p={1} pb={2}>
                  <Stack align="baseline">
                    <Stack.Item grow bold>
                      {item.name}
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        content="Claim"
                        disabled={bought}
                        onClick={() =>
                          act('select', {
                            item: item.id,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                  {item.desc}
                </Box>
              ))}
            </Stack.Item>
            <Stack.Item>
              <Box>
                <HunterObjectives />
              </Box>
            </Stack.Item>
          </Stack>
        }
      </Window.Content>
    </Window>
  );
};
