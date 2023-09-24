import { useLocalState } from '../tgui/backend';
import { Stack, Tabs } from '../tgui/components';
import { Window } from '../tgui/layouts';

type PowerInfo = {
  name: string;
  desc: string;
  cost: number;
};

export const AntagInfoWerewolf = (props: any, context: any) => {
  const [tab, setTab] = useLocalState(context, 'tab', 1);

  return (
    <Window width={620} height={580} theme="spookyconsole">
      <Window.Content>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            onClick={() => setTab(1)}
            selected={tab === 1}>
            Information
          </Tabs.Tab>
          <Tabs.Tab
            lineHeight="23px"
            onClick={() => setTab(2)}
            selected={tab === 2}>
            Powers
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <WerewolfInfo />}
        {tab === 2 && <WerewolfShop />}
      </Window.Content>
    </Window>
  );
};

const WerewolfInfo = (props: any, context: any) => {
  return (
    <Stack vertical fill>
      <Stack.Item>info</Stack.Item>
    </Stack>
  );
};

const WerewolfShop = (props: any, content: any) => {
  return (
    <Stack vertical fill>
      <Stack.Item>shop</Stack.Item>
    </Stack>
  );
};
