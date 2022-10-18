import { useBackend } from '../../tgui/backend';
import { Box, Button, Section, Stack, Icon } from '../../tgui/components';
import { Window } from '../../tgui/layouts';

const HunterObjectives = (props, context) => {
  const { act, data } = useBackend(context);
  const { objectives = [], bought } = data;
  return (
    <Stack vertical>
      <Stack.Item grow>
        {objectives.map((objective) => (
          <Box key={objective.explanation}>
            <Stack align="baseline">
              <Stack.Item grow bold>
                {objective.explanation}
              </Stack.Item>
            </Stack>
            <Icon
              name={objective.completed ? 'check' : 'times'}
              color={objective.completed ? 'good' : 'bad'}
            />
          </Box>
        ))}
      </Stack.Item>
    </Stack>
  );
};

export const HunterContract = (props, context) => {
  const { act, data } = useBackend(context);
  const { items = [], bought } = data;
  return (
    <Window width={670} height={500} theme="malfunction">
      <Window.Content scrollable>
        <Section title="Hunter's Contract" />
        {
          <Stack vertical fill>
            <Stack.Item grow>
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
            <Stack.Item grow>
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
