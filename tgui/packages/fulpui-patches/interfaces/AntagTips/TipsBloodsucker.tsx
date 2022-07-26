import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../../tgui/components';
import { resolveAsset } from '../../../tgui/assets';

export const TipsBloodsucker = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section fill>
      <Flex>
        <Flex.Item>
          You are a <b>Bloodsucker</b>, an undead blood-seeking monster living
          aboard Space Station 13.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          You regenerate your health slowly, you&#39;re weak to fire, and you
          depend on blood to survive. Don&#39;t allow your blood to run too low,
          or you&#39;ll enter a Frenzy!
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          Beware of your Humanity level! The more Humanity you lose, the easier
          it is to fall into a Frenzy!
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          Avoid using your Feed ability while near others, or else you will risk{' '}
          <i>breaking the Masquerade</i>!
        </Flex.Item>
        <Divider />
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`day.png`)} />
          Fear the daylight! Solar flares will bombard the station periodically,
          and your coffin can guarantee your safety.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`coffin.png`)} />
          Rest in a <b>Coffin</b> to claim it, and that area, as your lair.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          Once you have a Coffin claimed, you will learn new structures in the{' '}
          <b>Tribal</b> section of your crafting menu.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`vassalrack.png`)} />
          Examine your new structures to see how they function!
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item bold>
          Other Bloodsuckers are not necessarily your friends, but your survival
          may depend on cooperation. Betray them at your own discretion and
          peril.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
