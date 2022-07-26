import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../tgui/components';
import { resolveAsset } from '../../tgui/assets';
import { Window } from '../../tgui/layouts';

type Name = {
  name: string;
};

export const TipsMalf = (props, context) => {
  const { act, data } = useBackend<Name>(context);
  const { name } = data;
  return (
    <Window width={400} height={420} theme="hackerman">
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
                opacity={0.3}
                src={resolveAsset(`malf_ai.png`)}
              />
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              Similar to your human counterpart, you have been assigned objectives in your Antagonist Info UI that must be completed
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`beepsky.png`)}
              />
              You can use Bots to your advantage by emagging them through their UI, or calling them to locations using Robot Control in your AI modules.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`cyborg.png`)}
              />
              You can <b>hack cyborgs</b> by using the Research Director&#39;s cyborg control console.
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              You have access to the Syndicate radio channel, use the <b>:t</b> radio prefix to access it.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              You can use your <b>processing power</b> to purchase abilities through your Antagonist UI, ranging from upgraded cameras, upgraded turrets to even a Doomsday Device, if your objectives allow.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
