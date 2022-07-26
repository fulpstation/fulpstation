import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from 'tgui/components';
import { resolveAsset } from 'tgui/assets';
import { Window } from 'tgui/layouts';

type Name = {
  name: string;
};

export const TipsCultist = (props, context) => {
  const { act, data } = useBackend<Name>(context);
  const { name } = data;
  return (
    <Window width={400} height={430} theme="spookyconsole">
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
                src={resolveAsset(`bloodcult.png`)}
              />
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              You are a follower of the geometer of blood, Nar&#39;Sie!
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              In your bag, you will find some <b>Runed Metal</b> and a <b>Ritual Dagger.</b>
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`dagger.png`)}
              />
                Use your <b>Ritual Dagger</b> to create runes. Each rune has a unique function.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`archives.png`)}
              />
              Use the <b>Runed Metal</b> to create cult structures which will produce powerful equipment.
            </Flex.Item>
            <Divider />
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`sacrune.png`)}
              />
              To begin, you should gather converts by placing them over an <b>Offering Rune.</b>
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              There will be several other cultists on board, communicate with them using the commune button. Find a place to create a base, and keep cult structures hidden.
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              Before you can summon Nar&#39;Sie, you must first sacrifice a target for her on an offering rune. Check the top right of your screen for information on your target.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item bold>
              Your Cult Stun spell will not have full effect on Mindshielded people! Consider using alternative tactics when dealing with them.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
