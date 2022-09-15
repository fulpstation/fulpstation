import { useBackend } from '../../tgui/backend';
import { Box, Button, Section, Stack, Tabs } from '../../tgui/components';
import { Window } from '../../tgui/layouts';

const ConnectScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { connected } = data;
  return (
    <Section>
      <Button content={'Connect Uplink'} onClick={() => act('connect')} />
    </Section>
  );
};

export const InfilMarketUplink = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    connected,
    categories = [],
    items = [],
    currency,
    viewing_category,
  } = data;
  return (
    <Window width={670} height={300} theme="malfunction">
      <Window.Content scrollable>
        <Section
          title="Restricted Market"
          buttons={
            <Box color="green" bold fontSize={1.2}>
              {currency + ' Points'}
            </Box>
          }
        />
        {(!connected && <ConnectScreen />) || (
          <Stack vertical>
            <Stack.Item>
              <Tabs>
                {categories.map((category) => (
                  <Tabs.Tab
                    key={category}
                    selected={viewing_category === category}
                    onClick={() =>
                      act('set_category', {
                        category: category,
                      })
                    }>
                    {category}
                  </Tabs.Tab>
                ))}
              </Tabs>
            </Stack.Item>
            <Stack.Item grow>
              {items.map((item) => (
                <Box key={item.name} className="candystripe" p={1} pb={2}>
                  <Stack align="baseline">
                    <Stack.Item grow bold>
                      {item.name}
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        content={item.cost + 'PTs'}
                        disabled={item.cost > currency}
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
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
};
