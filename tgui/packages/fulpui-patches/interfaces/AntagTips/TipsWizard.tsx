import { Box, Flex, Divider, Section } from '../../../tgui/components';
import { resolveAsset } from '../../../tgui/assets';

export const render = () => {
  return <Tips />;
};

const Tips = () => {
  return (
    <Section fill>
      <Flex>
        <Flex.Item>You are a wizard sent by the Wizard Federation.</Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`spellbook.png`)} />
          You have been granted a <b>spellbook</b> with 10 spellpoints that you
          can spend to buy new spells. It can only be used on board of the
          Wizard&#39;s den.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`scroll.png`)} />
          Use your <b>scroll of teleportation</b> to get to the station.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          The details of your objective are stored within your Antagonist UI,
          although they are merely a suggestion.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          Spells can be upgraded by putting more points into them or refunded.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          As a wizard, you have a versatile loadout that can adapt depending on
          which playstyle you wish to adopt.
          <Box as="img" height="20px" src={resolveAsset(`mjolnir.png`)} />
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          You might be an agent of chaos, but how you choose to act is up to
          you.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
