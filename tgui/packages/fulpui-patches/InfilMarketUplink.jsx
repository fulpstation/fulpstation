import { useBackend } from '../tgui/backend';
import { Box, Button, Section, Stack, Tabs } from '../tgui/components';
import { Window } from '../tgui/layouts';

const ConnectScreen = (props) => {
  const { act, data } = useBackend();
  const { area, connecting_zone } = data;
  return (
    <Section>
      <Section>
        <Button content={'Connect Uplink'} onClick={() => act('connect')} />
      </Section>
      <Section>
        <Box color={area ? 'green' : 'red'} bold fontSize={1.2}>
          {area
            ? 'Signal detected'
            : 'No Signal detected, device must be activated in ' +
              connecting_zone}
        </Box>
      </Section>
    </Section>
  );
};

export const InfilMarketUplink = (props) => {
  const { act, data } = useBackend();
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
            <Box color={connected ? 'green' : 'red'} bold fontSize={1.2}>
              {connected ? currency + ' Points' : 'ERROR'}
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
                    }
                  >
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
