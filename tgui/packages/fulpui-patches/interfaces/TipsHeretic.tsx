import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../tgui/components';
import { resolveAsset } from '../../tgui/assets';
import { Window } from '../../tgui/layouts';

type Name = {
  name: string;
};

export const TipsHeretic = (props, context) => {
  const { act, data } = useBackend<Name>(context);
  const { name } = data;
  return (
    <Window width={400} height={420}>
      <Window.Content
        style={{ 'background': 'radial-gradient(circle, rgba(9,9,24,1) 54%, rgba(10,10,31,1) 60%, rgba(21,11,46,1) 80%, rgba(24,14,47,1) 100%);' }}>
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
                src={resolveAsset(`heretic.png`)}
              />
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              Eldritch ancient energies surge through you! You have been provided with a Living Heart to start your quest.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              Your antagonist UI page lays out your objectives and research paths. Once you choose a path, you are locked in it.
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`heart.png`)}
              />
              The <b>Living Heart</b> is primarily used to find your targets. Use the ability to track one of your four targets, Right click to track the latest one.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`mansus.png`)}
              />
              The <b>Mansus Grasp</b> is your starter spell, which can knockdown targets and apply minor burn damage. Certain paths will give your grasp more abilities.
            </Flex.Item>
            <Divider />
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`influence.png`)}
              />
              You might find <b>influences</b> around the station, Right-Click one with an empty hand to research them and gain knowledge, at the cost of making the influences visible to normal crew. These influences can be removed entirely using an Anomaly Neutralizer.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`heretic_rune.png`)}
              />
              With Mansus Grasp in your off-hand, use a pen on the ground to draw your <b>Sacrificial Rune</b>. This is used for all your ritual needs, such as sacrificing targets.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
