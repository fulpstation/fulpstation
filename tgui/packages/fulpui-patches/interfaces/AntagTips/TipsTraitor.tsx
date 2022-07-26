import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../../tgui/components';
import { resolveAsset } from '../../../tgui/assets';

export const TipsTraitor = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section>
      <Flex>
        <Flex.Item>
          The syndicate has provided you with a disguised uplink. It can either
          be your PDA, your headset, your pen or an internal uplink.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`radio.png`)} />
          Your uplink contains your objectives and tasks, select one and
          complete the instructions to get reputation and additional
          telecrystals.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`pda.png`)} />
          To utilize your <b>PDA</b> uplink, enter the messenger tab and set the
          ringtone as the code you have been provided.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`headset.png`)} />
          To utilize your <b>Headset</b> uplink, change its frequency to the
          frequency provided.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`pen.png`)} />
          To utilize the <b>pen</b> uplink, twist it to the first setting, then
          to the second one.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`implanter.png`)} />
          To utilize the <b>internal uplink</b>, use the action button on the
          top left of your screen to access the uplink menu.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          The uplink starts out with 20 telecrystals (16 if you use the internal
          uplink) which are utilized to purchase different items to aid you in
          fulfilling your objectives.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          The Syndicate has also given you and any other agents on board
          code-words which can be used to find eachother. They&#39;re
          highlighted in red and blue.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
