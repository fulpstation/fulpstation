import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../../tgui/components';
import { resolveAsset } from '../../../tgui/assets';

export const TipsVassal = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section fill>
      <Flex>
        <Flex.Item>
          You are a Vassal, enslaved to your Vampiric Master, you obey their
          instructions above all else.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          You have the ability tp <i>Recuperate</i>, allowing you to heal at the
          exchange of your own Blood.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          Fear Mindshields! You will get deconverted if you get mindshielded,
          resist them at all costs!
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`day.png`)} />
          Help ensure your Master is safe from Daylight! Solar flares will
          bombard the station periodically, and if your Master is exposed, they
          will burn alive.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          Your Master can optionally upgrade you into the Favorite Vassal.
          Depending on their Clan, you will get different benefits.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
