import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../tgui/components';
import { resolveAsset } from '../../tgui/assets';
import { Window } from '../../tgui/layouts';

type Name = {
  name: string;
};

export const TipsMonsterHunter = (props, context) => {
  const { act, data } = useBackend<Name>(context);
  const { name } = data;
  return (
    <Window width={400} height={400} theme="malfunction">
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
                src={resolveAsset(`monsterhunter.png`)}
              />
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              You are a Monster Hunter, after deciding to leave retirement, you are now fighting Monsters one last time!
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              You are a Human, but learned the arts of Hunter-Fu, and Flow, allowing you to stand while in critical condition.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              Use your abilities to your advantage! Try to deduce who the Monsters are, what they are, and plan how to eliminate them.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
