import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../tgui/components';
import { resolveAsset } from '../../tgui/assets';
import { Window } from '../../tgui/layouts';

type Name = {
  name: string;
};

export const TipsNukie = (props, context) => {
  const { act, data } = useBackend<Name>(context);
  const { name } = data;
  return (
    <Window width={400} height={450} theme="syndicate">
      <Window.Content>
        <Section>
          <Flex>
            <Flex.Item>
              <Box bold inline p={2}>
                You are the {name}!
              </Box>
              <Box
                position="absolute"
                height="12rem"
                as="img"
                opacity={0.4}
                src={resolveAsset(`nukie.png`)}
              />
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`radio.png`)}
              />
              The syndicate has provided you with a radio uplink with 25 starting telecrystals, scaling with the crew&#39;s population.
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`nuke.png`)}
              />
              You must detonate the nuclear bomb from your ship on the Nanotrasen station. To do that, you must get the nuclear disk.
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`disk.png`)}
              />
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              To get to the nuclear disk, you have a tablet with a program (Fission360) to locate it.
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
            To activate the nuke, you must put in the disk, type in the code, turn off the safety and enable it. You should first unanchor it, move it to the station, re-anchor it and then activate the nuke and take the disk away.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`mauler.png`)}
              />
              As a Nuclear Operative, you have different options for purchase depending on your strategy, whether stealth or loud. Ranging from combat mechs to hypnotic flashes.
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`flash.png`)}
              />
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
            The leader of the team starts out with a war declaration. If activated, they'll be prompted to write a custom message and declare war.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              Declaring war stops you from going to the station for 20 minutes, alerts the crew and gives the entire team telecrystals.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
