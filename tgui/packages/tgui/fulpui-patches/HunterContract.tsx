import { Box, Button, Image, Section, Stack } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Objective, ObjectivePrintout } from '../interfaces/common/Objectives';
import { Window } from '../layouts';

type ItemInfo = {
  item_id: string;
  item_name: string;
  item_desc: string;
};

type Info = {
  objectives: Objective[];
  items: ItemInfo[];
  rabbits_count: Number;
  all_rabbits_found: BooleanLike;
  all_completed: BooleanLike;
  used_up: BooleanLike;
  bought: BooleanLike;
};

const HunterObjectives = (props: any) => {
  const { act, data } = useBackend<Info>();
  const { objectives = [] } = data;
  if (!objectives) {
    return;
  }

  return <ObjectivePrintout fill objectives={objectives} />;
};

const HunterApocalypseButton = (props) => {
  const { act, data } = useBackend<Info>();
  const { all_completed, all_rabbits_found, rabbits_count, used_up } = data;

  return (
    <>
      <Section noTopPadding align="center">
        <Image
          height="96px"
          width="96px"
          src={resolveAsset(`monster_hunter.white_rabbit.png`)}
          verticalAlign="middle"
          style={{
            marginTop: '-32px',
          }}
        />
        <Box textAlign="center" fontSize="150%" className="candystripe" bold>
          Rabbits Found: {rabbits_count.toString()}&#47;5
        </Box>
      </Section>
      <Box>
        <Button
          fluid
          textAlign="center"
          align="center"
          content={'Commence Apocalypse'}
          fontSize="200%"
          disabled={!all_completed || !all_rabbits_found || used_up}
          onClick={() => act('claim_reward')}
          tooltip={
            'Unlocked once all objectives are completed and all rabbits are found. This will allow you to merge the station with Wonderland.'
          }
        />
      </Box>
    </>
  );
};

export const HunterContract = () => {
  const { act, data } = useBackend<Info>();
  const { items, bought, used_up } = data;
  if (bought && used_up) {
    return (
      <Window
        width={300}
        height={150}
        theme="spookyconsole"
        title="Completed Hunter's Contract"
      >
        <Window.Content>
          <Stack vertical fill>
            <Stack.Divider />
            <Box textAlign="center" fontSize="200%" pt={1}>
              Contract completed!
            </Box>
            <Box textAlign="center" italic pt={1} pb={1}>
              You are now obliged to do as you will— just don&#39;t interfere
              with the rabbits from Wonderland!
            </Box>
            <Stack.Divider />
          </Stack>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window
      width={bought ? 325 : 425}
      height={bought ? 295 : 550}
      theme="spookyconsole"
      title="Hunter's Contract"
    >
      <Window.Content scrollable>
        <Stack vertical fill>
          {!bought && (
            <>
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
                {items?.map((item) => (
                  <Box
                    key={item.item_name}
                    className="candystripe"
                    p={1}
                    pb={2}
                  >
                    <Stack align="baseline">
                      <Stack.Item grow bold>
                        {item.item_name}
                      </Stack.Item>
                      <Stack.Item pb={0.5}>
                        <Button
                          content="Claim"
                          disabled={bought}
                          onClick={() =>
                            act('select', {
                              item: item.item_id,
                            })
                          }
                        />
                      </Stack.Item>
                    </Stack>
                    {item.item_desc}
                  </Box>
                ))}
              </Stack.Item>
            </>
          )}
          <Stack.Divider />
          <Stack.Item>
            <HunterObjectives />
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>
            <HunterApocalypseButton />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
