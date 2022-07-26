import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../../tgui/components';
import { resolveAsset } from '../../../tgui/assets';

export const TipsAbductor = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section fill>
      <Flex>
        <Flex.Item>
          You and your teammate have been chosen by the mothership to go and
          capture some humans.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          There&#39;s two of you: the <b>scientist</b>, who must oversee the
          camera and surgery, and the <b>agent</b>, who must go down on the
          station to stun and cuff people.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`scitool.png`)} />
          The scientist must utilize his <b>console</b> and <b>science tool</b>,
          to scan disguises and scan the agent for retrieval if neccesary.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          The scientist must look for targets and send down the agent, after the
          target is captured the scientist must go down and use the science tool
          to mark the teleport target.
        </Flex.Item>
        <Divider />
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`alienorgan.png`)} />
          After that, he must do the{' '}
          <b>extraterrestrial experimental surgery</b>, which doesn&#39;t
          require any clothing to be removed.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`abaton.png`)} />
          The agent must be sent down by the scientist to stun and cuff a target
          and drag it into a hidden spot and wait for the scientist.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          People wearing <b>tinfoil hats</b> are immune to the sleep effect of
          abductor batons.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
