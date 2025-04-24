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

  return (
    <Stack vertical fill>
      <Stack.Item grow>
        <ObjectivePrintout fill objectives={objectives} />
      </Stack.Item>
    </Stack>
  );
};

const HunterApocalypseButton = (props: any) => {
  const { act, data } = useBackend<Info>();
  const { all_completed, all_rabbits_found, rabbits_count, used_up } = data;
  return (
    <Stack fill vertical align="center">
      <Stack.Item grow>
        <Section bold fontSize="125%" fill>
          <Image
            height="96px"
            width="96px"
            src={resolveAsset(`monster_hunter.white_rabbit.png`)}
            style={{
              verticalAlign: 'middle',
            }}
          />
          <Box textAlign="center">
            Rabbits Found: {rabbits_count.toString()}&#47;5
          </Box>
        </Section>
      </Stack.Item>
      <Stack.Item grow>
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
              'Only unlocked once all objectives are completed and rabbits are found, this will allow you to start your Final Reckoning.'
            }
          />
        </Box>
      </Stack.Item>
    </Stack>
  );
};

export const HunterContract = () => {
  const { act, data } = useBackend<Info>();
  const { items, bought } = data;
  return (
    <Window
      width={bought ? 325 : 400}
      height={bought ? 325 : 550}
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
                      <Stack.Item>
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
          <Stack.Item>
            <Section>
              <HunterObjectives />
            </Section>
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>
            <Box>
              <HunterApocalypseButton />
            </Box>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
