import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../../tgui/components';
import { resolveAsset } from '../../../tgui/assets';

export const TipsChangeling = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section fill>
      <Flex>
        <Flex.Item>
          You are a Changeling, a shapeshifting alien assuming the form of a
          crewmember on Space Station 13.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          You have the ability to take genomes, which serve as backup
          identities. To do this, you must take ANY human, and acquire their DNA
          through one of two methods.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`sting_extract.png`)} />
          Use the <b>DNA Extraction Sting</b> and sting a target to stealthily
          steal their DNA.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`absorb.png`)} />
          You can <b>absorb</b> humans to drain their DNA, husking them and
          draining them of fluids.
        </Flex.Item>
        <Divider />
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`emporium.png`)} />
          Use the <b>Cellular Emporium</b> to acquire special abilities which
          will help you achieve your objectives.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          Absorbing a body will allow you to <b>readapt</b> and purchase
          different abilities.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`tentacle.png`)} />
          Although you are difficult to kill, stealth and deception is your
          friend. Be cautious: other changelings could have an objective to
          absorb you.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
